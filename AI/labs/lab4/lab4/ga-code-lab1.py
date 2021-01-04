# -*- coding: utf-8 -*-
"""
Created on Tue Sep  1 10:17:54 2020

@author: sb15704
"""

# This code is provided for the first GA lab class for the AI unit (COMSM0014)

# It implements a very simple GA solving the "methinks it is like a weasel" problem.

# The brief for this lab comes in two parts.
# Both are available from the unit's Blackboard page for Week 4.
#   Part 0 will be circulated ahead of the lab.
#   Part 1 will be circulated at the start of the lab.

# Before the lab, please get this code running and play with the simple_main() and batch_main() function calls.

# The lab will require you to run different variants of this code and record the performance that results.
# You will benefit from being able to plot the data in good graphs. Look into how you want to do this.
# You will also have to make some small changes to the code to implement new variants of the GA in order to answer some of the questions.

# So please have a look at the code before the lab and try to understand how it works.

# Feel free to ask questions and discuss with others on the unit!


import random       # from random, we use "seed", "choice", "sample", "randrange", "random"
import statistics   # from statistics we just use "mean", "stdev"
import time


# Initialise the GA population
#   Fill an empty population array with N=pop_size random individuals
#   Each individual is represented by a Python dictionary with two elements: "solution" and "fitness"
#     each "fitness" is initialised to <None> as the associated solution has not yet been assessed
#     each "solution" is initialised to a string of random symbols from the alphabet
#     either each "solution" is the same random string (converged=True) or
#     each "solution" is a different random string (converged=False)
#     the function as provided doesn't implement the converged=True functionality
def initialise(pop_size, genome_length, genetic_alphabet, converged=False):

    pop = []

    while len(pop)<pop_size:
        solution = "".join([random.choice(genetic_alphabet) for _ in range(genome_length)])
        pop.append({"fitness":None, "solution":solution})

    return pop


# Count the number of locations for which two strings of the same length match.
#   E.g, matches of "red", "rod" should be 2.
def matches(str1, str2):
    return sum([str1[i]==str2[i] for i in range(len(str1))])


# Assess the fitness of each individual in the current population
#   For each individual, count the number of symbols in the solution that match the target string
#   Store this as the fitness of the individual (normalised by the target string length)
#   Maximum fitness is thus 1 (all symbols match); minimum fitness is 0 (no matches).
#   Sort the population by fitness with the best solution at the top of the list
#     * this last step is important because it helps us track the best solution and
#       will also be useful when we implement elitism...
def assess(pop, target):

    length = len(target)
    for i in pop:
        i["fitness"] = matches(i["solution"], target) / length

    return sorted(pop, key = lambda i: i["fitness"], reverse=True)    # <<< *important


# Run tournament selection to pick a parent solution
#   Consider a sample of tournament_size unique individuals from the current population
#   Return the solution belonging to the winner (the individual with the highest fitness)
def tournament(pop, tournament_size):

    competitors = random.sample(pop, tournament_size)

    winner = competitors.pop()
    while competitors:
        i = competitors.pop()
        if i["fitness"] > winner["fitness"]:
            winner = i

    return winner["solution"]


# Breed a new generation of solutions from the existing population
#   Generate N offspring solutions from a population of N individuals
#   Choose parents with a bias towards those with higher fitness
#   We can do this in a few different ways: here we use tournament selection
#   We can opt to employ 'elitism' which means the current best individual
#   always gets copied into the next generation at least once
#   We can opt to use 'crossover' (uniform or single point) which combines
#   two parent genotypes into one offspring
#   (Elitism is not yet implemented in the current code)
def breed(pop, tournament_size, crossover, uniform, elitism):

    offspring_pop = []

    #################
    if elitism:
        elite = pop[0]
        offspring_pop.append({"fitness": None, "solution": elite["solution"]})
    #################

    # offspring_pop 이 전체 population 이 되기 전까지 계속 off_spring 을 생성
    while len(offspring_pop) < len(pop):
        mum = tournament(pop, tournament_size)

        # crossover 을 해야 한다면
        if random.random() < crossover:
            if not uniform:
                dad = tournament(pop, tournament_size)
                offspring_pop.append({"fitness": None, "solution": cross(mum, dad)})
            else:
                dad = tournament(pop, tournament_size)
                offspring_pop.append({"fitness": None, "solution": uniform_cross(mum, dad)})

        # crossover 을 안해도 된다면
        else:
            offspring_pop.append({"fitness": None, "solution": mum})

    return offspring_pop


# Apply mutation to the population of new offspring
#   Each symbol in each solution may be replaced by a randomly chosen symbol from the alphabet
#   For each symbol in each solution the chance of this happening is set by the mutation parameter
#   (Elitism is not yet implemented in the current code)
#   (Python doesn't let us change a character at location i within a string like this: string[i]="a"
#   so we splice a new character into the string like this: string = beginning + new + end)
def mutate(pop, mutation, alphabet, elitism):

    length = len(pop[0]["solution"])
    for i in pop[elitism:]:
        # pop[elitism:] means we don't mutate the elite; original code supplied to students doesn't have this
        for j in range(length):
            if random.random() < mutation:
                i["solution"] = i["solution"][:j] + random.choice(alphabet) + i["solution"][j+1:]

    return pop


# Crossover the solution string of two parents to make an offspring
#   (This code implements 'one-point crossover')
#   Pick a random point in the solution string,
#   Use the mum's string up to this point and the dad's string after it
def cross(mum, dad):
    point = random.randrange(len(mum))
    # 앞에꺼는 엄마꺼 가져오고 뒤에꺼는 아빠가 가져온다.
    return mum[:point]+dad[point:]

# vv This code is for q3c uniform crossover option vv
# Uniform crossover of two parent solution strings to make an offspring
# pick each offspring solution symbol from the mum or dad with equal probability
# 아빠/엄마를 1/2 확률로 번갈아가면서 뽑는다.
def uniform_cross(mum, dad):
    return "".join([mum[i] if random.choice([True, False]) else dad[i] for i in range(len(mum))])

# Write a line of summary stats for population pop at generation gen
#   if File is None we write to the standard out, otherwise we write to the File
#   (In addition to writing out the max, min, and mean fitness for the pop, we
#   could write out a measure of population "covergence", e.g., std dev of fitness
#   or the match() between the best solutionand the median solution in the pop
#   but that's not implemented here yet.)
def write_fitness(pop, gen, file=None):

    fitness = []
    for p in pop:
        fitness.append(p["fitness"])

    line = "{:4d}: max:{:.3f}, min:{:.3f}, mean:{:.3f}".format(gen, max(fitness), min(fitness), statistics.mean(fitness))

    if file:
        file.write(line+"\n")
    else:
        print(line)


# The main function for the GA
#  The function takes a number of arguments specifying various parameters and options
#  each argument has a default value which can be overloaded in the function call..
#   Seed the pseudo-random number generator (using the system clock)
#     so no two runs will have the same sequence of pseudo-random numbers
#   Set the length of the solution strings to be the length of the target string
#   Set the mutation rate to be equivalent to "on average 1 mutation per offspring"
#   Initialise a population of individuals
#   Assess each member of the initial population using the fitness function
#   Run a maximum of max_gen generations of evolution
#     (stopping early if we find the perfect solution)
#   Each generation of evolution comprises:
#     increment the generation counter
#     breed a new population of offspring
#     mutate the new offspring
#     assess each member of the new population using the fitness function and sort pop by fitness
#     track the best (highest fitness) solution in the current population (the 0th item in the list)
#     if we are writing stats and we want to write stats this generation:
#       write out some stats
#   Return the final generation count and the best individual from the final population
def do_the_ga(pop_size=100, tournament_size=2, crossover=0.0, uniform=False,
              elitism=False, max_gen=1000, converged=False, write_every=1, file=None, mutation=1,
              target="methinks it is like a weasel",
              alphabet="abcdefghijklmnopqrstuvwxyz "):

    random.seed()

    length = len(target)
    mutation = mutation/length  # << this line in the original code sets the mutation relative to the genome length

    pop = initialise(pop_size, length, alphabet, converged)
    pop = assess(pop, target)

    generation = 0
    best = pop[0]
    while generation < max_gen and best["fitness"] < 1:
        generation += 1
        pop = breed(pop, tournament_size, crossover, uniform, elitism)
        pop = mutate(pop, mutation, alphabet, elitism)
        pop = assess(pop, target)
        best = pop[0]
        if write_every and generation % write_every == 0:
            # show max, min, and mean
            write_fitness(pop, generation, file)

    return generation, best


####################################################################
# Info on the parameters that do_the_ga() takes, and their defaults:
####################################################################
#
# The following variables parameterise the GA, a default value and a brief description is given for each
#
#    target   = "methinks it is like a weasel" # this is the 28-character target solution that we are trying to evolve
#    alphabet = "abcdefghijklmnopqrstuvwxyz "  # this is the set of 27 symbols from which we can build potential solutions
#
#    pop_size = 100                            # the number of individuals in one generation
#    tournament_size = 2                       # the size of the breeding tournament
#    mutation = 1.0/length                     # the chance that each symbol will be mutated
#
#    crossover = 0.0                           # the chance that an offspring is the result of sexual crossover. default: on average 1 mutation per offspring
#    uniform  = False                          # use uniform crossover? otherwise use the default: single-point crossover
#    elitism  = False                          # is elitism turned on or off? otherwise use the default: no elitism
#    converged = False                         # is the initial population converged? otherwise use the default: not converged
#
#    max_gen  = 1000                           # the maximum number of evolutionary generations that will be simulated
#
#    write_every = 1                           # write out some summary stats every x generations - can be useful to set this to 10 or 100 to speed things up, or set it to zero to never write stats
#    file  = None                              # write the stats out to a file, or to std out if no file is supplied
#
####################################################################


# Examples of how to call the GA...
def simple_main():
    print("=====Entering simple_main()=====")
    time.sleep(1)
    # call the GA with the default set up, receive the final generation count and the final best individual
    gens, best = do_the_ga()
    print("\n=====1st=====\n")
    # {1000} generations yielded: '{methi kqrit is lekhqa weasea}' ({0.750})
    print("{:4d} generations yielded: '{}' ({:.3f})".format(gens, best["solution"], best["fitness"]))

    input("hit return to continue")

    # call the GA with the default set up (but write stats to a file), receive the final generation count and the final best individual
    # (be careful about over-writing your output file if you run this again!)
    print("\n=====2nd=====\n")
    with open("ga_output.dat", 'w') as f:
        gens, best = do_the_ga(file=f)
        print("{:4d} generations yielded: '{}' ({:.3f})".format(gens, best["solution"], best["fitness"]))
    input("hit return to continue")

    print("\n=====3rd=====\n")
    # call the GA with a longer target string than the default set up, don't bother writing out any stats during evolution
    gens, best = do_the_ga(target="something quite a bit longer than methinks it is like a weasel", write_every=0)
    print("{:4d} generations yielded: '{}' ({:.3f})".format(gens, best["solution"], best["fitness"]))
    input("hit return to continue")


# Example of how we might explore the impact of varying a parameter on the performance of our GA
def batch_main():

    print("\n=====Entering batch_main()=====\n")
    time.sleep(1)
    # open a file to store the results in...
    with open("ga_output_max_gen_100_to_6400.dat",'w') as f:
        # loop over different parameter values for population size to see what difference it makes..
        for max_gen in [100, 200, 400, 800, 1600, 3200]:
            # call the GA - tell it to only write out stats for the final generation of evolution..
            gens, best = do_the_ga(max_gen=max_gen, file=f, write_every=max_gen)
            print("With max_gen={:4d}, {:4d} generations yielded: '{}' ({:.3f})".format(max_gen, gens, best["solution"], best["fitness"]))


# Complete the lab by writing code for each of these empty functions:

# q1 just requires calling the do_the_ga() function with the standard parameters
def q1():
    gens, best = do_the_ga()
    print("{:4d} generations yielded: '{}' ({:.3f})".format(gens, best["solution"], best["fitness"]))

# q2a requires calling the do_the_ga() function repeatedly with different values for the tournament size...

# 토너먼트 사이즈를 변경
# 토너먼트의 사이즈가 크면 클수록 훨씬 더 성능이 좋아진다. 그만큼 더 많이 competition 하니까 당연한 결과이다.
def q2a():
    for ts in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 40, 80, 100]:
        gens, best = do_the_ga(tournament_size=ts, write_every=0)
        print("tournament: {:3d} \n {:4d} generations yielded: '{}' ({:.3f})".format(ts, gens,best["solution"],best["fitness"]))

# 타켓을 변경. 타켓이란 우리가 맞추고자 하는 단어/문장
# 타켓이 길어질수록 잘 못맞추는거 같음. 확실히 짧으면 잘 맞추는거 같다.
def q2b():
    for target in [
    "methinks",
    "methinks it is like",
    "methinks it is like a weasel",
    "methinks it is like a weasel but longer",
    "methinks it is like a weasel but way much longer indeed"
    ]:
        gens, best = do_the_ga(target=target, tournament_size=2, write_every=0)
        print("target: {} \n {:4d} generations yielded: '{}' ({:.3f})".format(target, gens,best["solution"],best["fitness"]))

# 알파벳을 변경. 쉽게 생각해서 정의역이라고 생각하면 된다. 어떤 alphabet space 로 부터 target 를 생성할 것인가?
# 코드를 돌려보면 alphabet 의 사이즈가 클수록 정확도가 떨어지는 것을 관측 할 수 있다.
def q2c():
    for alphabet in [
    "abcdefghijklmnopqrstuvwxyz ",
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ",
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!£$%^&*()'[]{}@:~#;<>,./?|\`¬ "
    ]:
        gens, best = do_the_ga(alphabet=alphabet, tournament_size=3, write_every=0)
        print("alphabet: {:2d} \n {:4d} generations yielded: '{}' ({:.3f})".format(len(alphabet), gens,best["solution"],best["fitness"]))

# pop size : the number of individuals in one generation
# 한번의 generation 마다 individuals 을 많이 생성해주면 tournament 를 통해서 좋은 놈이 올라올 확률이
# 높아지기 때문에 pop_size 를 커지게 할수록 정확도가 좋아진다.
def q2d():
    for pop_size in [10, 20, 40, 80, 160, 320, 640, 1280]:
        gens, best = do_the_ga(pop_size=pop_size, tournament_size=3, write_every=0)
        print("With pop_size = {:4d} \n {:2d} generations yielded: '{}' ({:.3f})"
              .format(pop_size, gens, best["solution"], best["fitness"]))

# adjust mutation : 변이를 조정하면서 결과를 살펴보면 된다.
# mutation = 0 --> mutation 이 하나도 일어나지 않는다.
# mutation = 1 --> mutation 이 1/len(target) 로 일어난다. 즉 타겟의 알파벳 중에서 하나만 바뀐다고 생각하면 된다.
def q2e():
    for mutation in [0, 0.05, 0.1, 0.25, 0.33, 0.5, 1.0, 2.0, 3.0, 4.0, 5.0, 28.0]:
        gens, best = do_the_ga(mutation=mutation, write_every=0)
        print("With m={:.2f} \n {:2d} generations yielded: '{}' ({:.3f})"
              .format(mutation, gens, best["solution"], best["fitness"]))


# 엘리트를 무조건 선정하는것은 매우 도움이 된다. 근데 얼마나 엘리트를 너무 많이 선정하면 (현재는 가장 좋은것 하나만 선택) premature convergence 할 수 있음.
# 근데 가장 좋은것 하나만 선택하는 것도 premature convergence 할 수 있음. 공책 설명 참고
# It improves the performance of the GA
def q3a():
    print("\nElitism == TRUE\n")
    for run in range(10):
        elitism = True
        gens, best = do_the_ga(elitism=elitism, write_every=0)
        print("With Elitism={}, {:2d} generations yielded: '{}' ({:.3f})"
              .format(elitism, gens, best["solution"], best["fitness"]))
    print("\nElitism == FALSE\n")
    for run in range(10):
        elitism = False
        gens, best = do_the_ga(elitism=elitism, write_every=0)
        print("With Elitism={}, {:2d} generations yielded: '{}' ({:.3f})"
              .format(elitism, gens, best["solution"], best["fitness"]))

# check the performance of the GA by changing 'converged' parameter
# converged 되었다는 것은 --> we initialise the first generation of solutions
# to be N random strings. What if the initial population was made up of N copies
# of one random string? We describe this population as *converged*
# because all the members are the same

# 이유:
# Converged or random initial population doesn't make any difference?
# This is because any inital diversity in the population collapses quickly
# wiping out the difference between the two scenarios
# This can be shown by plotting a measure of convergence over time
def q3b():
    print("\nConverged == TRUE\n")
    for run in range(10):
        converged = True
        gens, best = do_the_ga(converged=converged, tournament_size=2, write_every=0)
        print("With Converged={} \n {:2d} generations yielded: '{}' ({:.3f})"
              .format(converged, gens, best["solution"], best["fitness"]))

    print("\nConverged == FALSE\n")
    for run in range(10):
        converged = False
        gens, best = do_the_ga(converged=converged, tournament_size=2, write_every=0)
        print("With Converged={} \n {:2d} generations yielded: '{}' ({:.3f})"
              .format(converged, gens, best["solution"], best["fitness"]))

# checking 'crossover'. Crossover 의 비율을 높여주면 더 performance 가 높아진다.
def q3c():
    # Crossover straightforwardly improves performance
    # Is uniform crossover a bit better? Might need several runs and a t-test?

    print("\n=====One point CROSSOVER=====\n")
    for crossover in [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.2]:
        gens, best = do_the_ga(crossover=crossover, write_every=0)
        print("With 1-point crossover={:.2f}, {:2d} generations yielded: '{}' ({:.3f})"
              .format(crossover, gens, best["solution"], best["fitness"]))

    print("\n=====Uniform point CROSSOVER=====\n")
    for crossover in [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.2]:
        gens, best = do_the_ga(crossover=crossover, uniform=True, write_every=0)
        print("With uniform crossover={:.2f}, {:2d} generations yielded: '{}' ({:.3f})"
              .format(crossover, gens, best["solution"], best["fitness"]))


# This is a bit more involved - maybe only something that a student who has rocketed through the other questions will have time for
#  Here I show how I would look at how convergence changes over time for four different values of mutation probability
#  In each case I want to compare how fitness changes over evolutionary time with how solution diversity changes over time
#  I could measure "diversity" in many ways but an easy one is how different is the current best solution from the current median solution (using the matches() function)
#  The resulting graphs should show that:
#    very low mutation rate (0.05/L) means rapid loss of diversity in the population (="prematurely convergence") resulting in very slow progress
#    very high mutation rate (5/L) means very high diversity in the population because high mutation prevents heritability of good genes and hamstrings selection
#    intermedite mutation rate (0.05/L or 1/L) allows moderate diversity that is lost as the population gets closer to the optimal solution
def q4():
    # open a file to store the results in...
    with open("ga_output_mut_convergence_data.dat", 'w') as f:
        # loop over different parameter values for mutation rate to see what difference it makes..
        for m in [0.05, 0.5, 1.0, 5.0]:
            gens, best = do_the_ga(m=m, write_every=1, file=f, max_gen=500)  # call the GA with the right parameters
            print("With m={:.2f}, {:2d} generations yielded: '{}' ({:.3f})".format(m, gens, best["solution"], best["fitness"]))


# Calling two examples main functions

# uncomment this section
# simple_main()
# batch_main()

# Function calls for new functions to be written for each of the Lab Sheet Questions
# q1()
# q2a()
# q2b()
# q2c()
# q2d()
q2e()
# q3a()
# q3b()
# q3c()
# q4()





# I've also provided a separate python file with a "t-test" function in it in case anyone
# wants to use a t-test to check whether the behaviour of two GAs is significantly different
# This isn't required - but if you were doing a proper analysis of GA performance you'd want
# to think about stats of some kind...
from t_test import t_test as t_test
# check the t-test.py file for more info on how to call the t_test function
