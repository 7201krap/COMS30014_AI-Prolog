# -*- coding: utf-8 -*-
"""
Created on Tue Sep  1 10:17:54 2020

@author: sb15704
"""

import random       # we use "seed", "choice", "sample", "randrange", "random", "shuffle"
import statistics   # from statistics we just use "mean", "stdev"

# Initialise a GA Population
#   Fill an empty population array with N=pop_size new individuals
#   Each individual is represented by a dictionary with two elements: "fitness" and "solution"
#     each "fitness" is initialised to 0 as the associated solution has not yet been assessed
#     if zeropop is True (which is appropriate if we are replicating Cartlidge & Bullock, 2004)
#       each "solution" is initialised to a string of "0"s from the (binary) alphabet
#     otherwise, if zeropop is False (which is appropriate if we are just running regular evolution):
#       each "solution" gene is initialised to a different random symbol drawn from the (binary) alphabet
def initialise(pop_size, length, alphabet, zeropop=True):

    pop = []

    while len(pop)<pop_size:
        # each "solution" is initialised to a string of "0"s from the (binary) alphabet
        if zeropop:
            pop.append({"fitness":0, "solution":"0"*length})
        # if zeropop is False (which is appropriate if we are just running regular evolution):
        # each "solution" gene is initialised to a different random symbol drawn from the (binary) alphabet
        else:
            pop.append({"fitness":0, "solution":"".join([random.choice(list(alphabet)) for _ in range(length)])})

    return pop


# Apply Virulence Function
#    As per the Cartlidge and Bullock (2004) paper, we can impose a virulence function
#    on parasite fitness, either rewarding or punishing parasites that tend to win more
#    or less games vs. their host opponents.
#    First we normalise all parasite scores by dividing by the current maximum score
#    Then we map each parasite's normalised score (x) through the virulence function
#    which takes a parameter "para_lambda" that can range between 1.0 (maximum virulence)
#    and 0.5 (minimum virulence):
#      fitness = (2*x/par_lambda) - (x^2)/(para_lambda^2)
#    (Note, if all the original fitness values in the parasite population are zero,
#    then we just return them unchanged to avoid a division by zero problem during
#    normalisation.)
def apply_virulence(para_pop, para_lambda):

    # ------------------------------------------------------------------------------------------------------------
    #    (Note, if all the original fitness values in the parasite population are zero,
    #    then we just return them unchanged to avoid a division by zero problem during
    #    normalisation.)
    max_para_fitness = 0
    for i in range(len(para_pop)):
        if para_pop[i]["fitness"] > max_para_fitness:
            max_para_fitness = para_pop[i]["fitness"]

    if max_para_fitness==0:
        return para_pop
    # ------------------------------------------------------------------------------------------------------------

    for i in range(len(para_pop)):
        # we normalise all parasite scores by dividing by the current maximum score
        normalised_score = para_pop[i]["fitness"]/max_para_fitness
        para_pop[i]["fitness"] = (2 * normalised_score / para_lambda) - ( (normalised_score**2)/(para_lambda**2) )

    return para_pop


# Assess the Fitness of Each Individual in the Current Population
#   We assess each individual host against n=num_competitions randomly chosen parasites.
#   i.e., for each of the n rounds of competitions we pair each host with a different random parasite
#   In each competition, we check whether the host or the parasite have more '1's in their solution.
#   Ties are broken in favour of the host. The competition winner gets a point of fitness.
#   Then we normalise each fitness score by dividing by the number of competitions.
#   So each parasite and host have a score between 0 (no wins) and 1 (no losses)
#   If the para_lambda parameter is between 0.5 and 1.0 we apply the virulence
#     function to the parasite fitness scores
#   Finally, we sort each population by fitness with the best solution at the top of the list
def assess(host_pop, para_pop, num_competitions, para_lambda):

    for competition in range(num_competitions):
        order = list(range(len(para_pop)))
        random.shuffle(order)

        for i in range(len(host_pop)):

            host = host_pop[i]
            para = para_pop[order[i]]

            # The competition winner gets a point of fitness.
            # host 의 1이 parasite 보다 많다면
            if host["solution"].count("1") >= para["solution"].count("1"):
                host["fitness"]+=1
            # parasite 1이 host 보다 많다면
            else:
                para["fitness"]+=1

    # normalisation: Then we normalise each fitness score by dividing by the number of competitions.
    # host 와 parasite 의 fitness 는 이제 0 (no wins) ~ 1 (no losses) 사이의 값을 가진다.
    for i in range(len(host_pop)):
        host_pop[i]["fitness"]/=num_competitions
        para_pop[i]["fitness"]/=num_competitions

    # If the para_lambda parameter is between 0.5 and 1.0 we apply the virulence
    # 다양성이 큰게 항상 좋은 것은 아니다.
    # virulence == 0.5  --> null virulence : 다양성 없다. Beat as many hosts as possible
    # virulence == 0.75 --> moderate virulence : parasites are encourage to achieve a win-rate 3/4 that of the hightest scoring current parasite
    # virulence == 1    --> maximum virulence : 다양성이 크다. Equivalent of canonical parasites
    if para_lambda and 0.5 <= para_lambda <= 1.0 :
        para_pop = apply_virulence(para_pop, para_lambda)

    # we sort each population by fitness with the best solution (individuals/genes) at the top of the list
    return sorted(host_pop, key = lambda i: i["fitness"], reverse=True), sorted(para_pop, key = lambda i: i["fitness"], reverse=True)


# Run Tournament Selection to Pick a Parent (same as code in GA Lab #1)
#   Consider a sample of tournament_size unique individuals
#   Return the solution belonging to the winner (the individual with the highest fitness)
def tournament(pop, tournament_size):

    competitors = random.sample(pop, tournament_size)

    winner = competitors.pop()
    while competitors:
        i = competitors.pop()
        if i["fitness"] > winner["fitness"]:
            winner = i

    # Return the solution belonging to the winner
    # winner : the individual with the highest fitness
    return winner["solution"]


# Breed a New Generation of Solutions from the Existing Population
#   Generate N offspring solutions from a population of N individuals
#   Choose each mum with a bias towards those individuals with higher fitness
#   We can do this in a few different ways: here we use tournament selection
#   We don't use elitism and reproduction is asexual - to keep things simple
#   N 명으로 구성된 population 에서 부터 N offspring solution 을 만든다.
def breed(pop, tournament_size):

    offspring_pop = []

    while len(offspring_pop)<len(pop):
        mum = tournament(pop, tournament_size)
        offspring_pop.append({"fitness":0, "solution":mum})

    return offspring_pop


# Apply Mutation to the Population of New Offspring
# (Using a 'mutation bias' if one is given)
#   For each symbol in each solution the chance that it is replaced by a new random
#     symbol is set by the mutation_rate parameter.
#   When a symbol is set to be mutated, whether or not there is a *bias* on which
#     new symbol is picked from the alphabet is determined by the bias parameter
#     which is a list the same length as the alphabet.
#   An alphabet of "01" and bias=["0.5", "0.5"] means pick "0" and "1" with equal chance.
#   An alphabet of "01" and bias=["0.2", "0.8"] means pick "1" four times as often as "0".
#   An alphabet of "01" and bias=["0.0", "1.0"] means always pick "1".
#   The default is to implement an equal chance of choosing each symbol in the alphabet.
def mutate(pop, length, mutation_rate, alphabet, bias=None):

    if bias is None:  # bias 가 없다면
        # [(1/2)]*2 --> [0.5, 0.5]
        # bias = [0.5, 0.5]
        bias = [1.0/len(alphabet)]*len(alphabet)

    for i in pop:
        for j in range(length):
            if random.random() < mutation_rate:
                # individual(i) 의 j 번째 index 를 mutate 한다.
                # random.choices(alphabet, bias) --> ['0'] or ['1']
                i["solution"] = i["solution"][:j] + random.choices(alphabet, bias)[0] + i["solution"][j+1:]

    return pop


# Write Out a Line of Summary Stats for the Host and Parasite Populations
#   if file is None, we write to the standard out, otherwise we write to the file
#   (In addition to writing out the best solution, its relative fitness and
#   absolute fitness, we could write out population statistics for the hosts and
#   for the parasites, and we could also output a measure of population "covergence",
#   e.g., std dev of fitness scores, or the match() between the best solution and
#   the median solution in the pop but that's not implemented here yet.)
def write_fitness(hosts, paras, gen, file=None):

    best_host = hosts[0]
    best_para = paras[0]
    best_host["objective"] = best_host["solution"].count("1")
    best_para["objective"] = best_para["solution"].count("1")
    line1 = "{:4d} host: '{}' ({:.3f}) = {:3d}".format(gen, best_host["solution"], best_host["fitness"], best_host["objective"])
    line2 = "{:4d} para: '{}' ({:.3f}) = {:3d}".format(gen, best_para["solution"], best_para["fitness"], best_para["objective"])

    # host_fitness = [ h["fitness"] for h in hosts ]
    # para_fitness = [ p["fitness"] for p in paras ]
    # line1 += ", max:{:.3f}, min:{:.3f}, mean:{:.3f}".format(max(host_fitness), min(host_fitness), statistics.mean(host_fitness))
    # line2 += ", max:{:.3f}, min:{:.3f}, mean:{:.3f}".format(max(para_fitness), min(host_fitness), statistics.mean(para_fitness))

    if file:
        file.write(line1+"\n")
        file.write(line2+"\n")
    else:
        print(line1)
        print(line2)


# The Main Function for the Coevolutionary GA
#  The function takes a number of arguments specifying various parameters and options
#   - each argument has a default value
#    We seed the pseudo-random number generator (using the system clock)
#     - so that no two runs will have the same sequence of pseudo-random numbers
#    We initialise a population of individual "hosts"
#     - these are the solution "designs" that we are interested in
#    We initialise a population of individual "parasites"
#     - these are the solution "challenges" against which our hosts will coevolve
#    We assess each member of the two initial populations by calling assess()
#    We run max_gen generations of (co-)evolution:
#     Each generation comprises the following steps:
#      increment the generation counter
#      breed a new population of offspring hosts
#      if we are implementing coevolution: breed a new population of offspring parasites
#      otherwise: generate a new population of random parasites
#      mutate the new offspring hosts and mutate the new offspring parasites
#      assess each member of the two new populations
#      if we are writing stats and we want to write stats *this generation*:
#        write out some stats
#    We return the final generation count and the best (0th) host and parasite from the final populations
def do_the_ga(pop_size=50, length=100, tournament_size=5, max_gen=600, mutation_rate=0.03, para_lambda=0.75,
              num_competitions=10, alphabet="01", host_bias=[0.5, 0.5], para_bias=[0.4, 0.6], coevolution=True,
              write_every=10, file=None):

    random.seed()

    # We initialise a population of individual "hosts"
    host_pop = initialise(pop_size, length, alphabet, zeropop = coevolution) # zeropop is a flag determining whether we initialise with 000.. bit strings or not
    # We initialise a population of individual "parasites"
    para_pop = initialise(pop_size, length, alphabet, zeropop = coevolution) # zeropop is a flag determining whether we initialise with 000.. bit strings or not

    # We assess each member of the two initial populations by calling assess()
    host_pop, para_pop = assess(host_pop, para_pop, num_competitions, para_lambda)

    # We run max_gen generations of (co-)evolution:
    generation = 0
    while generation < max_gen:
        # increment the generation counter
        generation += 1

        # breed a new population of offspring hosts
        host_pop = breed(host_pop, tournament_size)
        # if we are implementing coevolution: breed a new population of offspring parasites
        if coevolution:
            para_pop = breed(para_pop, tournament_size)

        # otherwise: generate a new population of random parasites
        else:
            para_pop = initialise(pop_size, length, alphabet, zeropop = coevolution) # if we aren't doing coevolution just make a random bunch of parasites instead

        # mutate the new offspring hosts and mutate the new offspring parasites
        host_pop = mutate(host_pop, length, mutation_rate, alphabet, host_bias)
        para_pop = mutate(para_pop, length, mutation_rate, alphabet, para_bias)

        # assess each member of the two new populations
        host_pop, para_pop = assess(host_pop, para_pop, num_competitions, para_lambda)

        if write_every and generation % write_every==0:
            write_fitness(host_pop, para_pop, generation, file)

    best_host = host_pop[0]
    best_para = para_pop[0]
    best_host["objective"] = best_host["solution"].count("1")
    best_para["objective"] = best_para["solution"].count("1")

    return generation, best_host, best_para



# Example of how to call the GA...
def simple_main():

    # # call the GA with the default set up, receive the final generation count and the best individual
    # gens, best_host, best_para = do_the_ga()
    # print("\nDone: Standard set up")
    # print("{:4d} host: '{}' ({:.3f}) = {:3d}".format(gens, best_host["solution"], best_host["fitness"], best_host["objective"]))
    # print("{:4d} para: '{}' ({:.3f}) = {:3d}".format(gens, best_para["solution"], best_para["fitness"], best_para["objective"]))
    #
    # print("")

    # call the GA with the default set up, dump output every generation to a file called "coev-out.dat"
    with open("coev-out.dat",'w') as f:
        gens, best_host, best_para = do_the_ga(file=f, write_every=1, coevolution=True)
    print("\nDone: Standard set up; Wrote data to coev-out.dat")
    print("{:4d} host: '{}' ({:.3f}) = {:3d}".format(gens, best_host["solution"], best_host["fitness"], best_host["objective"]))
    print("{:4d} para: '{}' ({:.3f}) = {:3d}".format(gens, best_para["solution"], best_para["fitness"], best_para["objective"]))

simple_main()




########################
# Parameters and set up:
#
# The following variables parameterise the GA, a default value and a brief description is given for each
#
#    alphabet = "01"                           # this is the set of symbols from which we can build potential solutions
#
#    pop_size = 50                             # the number of individuals in one generation
#    length = 100                              # the length of a solution bit string (both host and parasite)
#    tournament_size = 5                       # the size of the breeding tournament
#    mutation = 0.03                           # the chance that each symbol will be mutated
#
#    coevolution = True                        # flag that determines whether we are doing coeovlution or just evolution
#
#    para_lambda = 1.0                         # the lambda parameter for parasite virulence in range [0.5, 1.0]
#    num_competitions = 10                     # number of tests that a host will face during assessment
#    host_bias = [0.5,0.5]                     # mutation bias for hosts; the default is unbiased mutation "0"s and "1"s are equally likely
#    para_bias = [0.25,0.75]                   # mutation bias for parasites; default is "1"s three times as likely as "0"s
#
#    max_gen  = 600                            # the maximum number of evolutionary generations that will be simulated
#
#    write_every = 10                          # write out some summary stats every x generations - can be useful to set this to 10 or 100 to speed things up, or set it to zero to never write stats
#    file = None                               # write the stats out to a file, or to std out if no file is supplied
#
####################################################################

