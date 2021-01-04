import numpy as np
import re
import matplotlib.pyplot as plt

f = open("coev-out.dat", 'r')
file_name = "coev-out.dat"
# initialisation and settings finishe here

def file_len(fname):
    with open(fname) as f:
        for i, l in enumerate(f):
            pass
    return i + 1

gens_counter = []

host_fitness = []
host_ones    = []

para_fitness = []
para_ones    = []

for i in range(file_len(file_name)):
    line = f.readline()
    nums = re.findall('[0-9]+', line)

    # generation counter
    gen  = nums[0]

    # fitness of the individual
    fitness_lhs = nums[-3]
    fitness_rhs = nums[-2]
    fitness = fitness_lhs + "." + fitness_rhs

    # how many ones in the individual
    ones = nums[-1]

    # convert a string format to a number format
    gen     = int(gen)
    fitness = float(fitness)
    ones    = int(ones)

    if i % 2 == 0:
        # host
        gens_counter.append(gen)
        host_fitness.append(fitness)
        host_ones.append(ones)
    else:
        # parasite
        para_fitness.append(fitness)
        para_ones.append(ones)


f.close()

std_host_ones = np.std(host_ones)
std_para_ones = np.std(para_ones)

print(" ===== Standard deviation of number of 1's ===== ")
print("std_host_ones: ", std_host_ones, "std_para_ones: ", std_para_ones)

# UNCOMMENT THIS SECTION IF YOU NEED TO SEE EACH VALUE OF FITNESS AND NUMBER OF ONES
# print("===== HOST_FITNESS =====")
# print(host_fitness)
# print("===== HOST_ONES =====")
# print(host_ones)
# print()
# print()
# print("===== PARASITE =====")
# print(para_fitness)
# print("===== PARA_ONES =====")
# print(para_ones)

# Fitness over Generation
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 6))
ax1.plot(gens_counter, host_fitness, c='r', label='host')
ax1.plot(gens_counter, para_fitness, c='g', label='para')
ax1.set_title("Fitness over Generations, Host vs Parasite")
ax1.set_xlim([0, len(gens_counter)])
ax1.set_ylim([0, 1.1])
ax1.set_xlabel('generation')
ax1.set_ylabel('fitness')
ax1.legend()

# Number of 1's over Generation
ax2.plot(gens_counter, host_ones, c='r', label='host')
ax2.plot(gens_counter, para_ones, c='g', label='para')
ax2.set_title("1's over Generations, Host vs Parasite")
ax2.set_xlim([0, len(gens_counter)])
ax2.set_ylim([0, 110])
ax2.set_xlabel('generation')
ax2.set_ylabel("1's")
ax2.legend()

plt.show()
