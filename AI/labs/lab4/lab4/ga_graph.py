import numpy as np
import re
import matplotlib.pyplot as plt

# initialisation and settings
max = []
min = []
mean = []

max_xs  = np.linspace(0, 1000, 1000)
min_xs  = np.linspace(0, 1000, 1000)
mean_xs = np.linspace(0, 1000, 1000)

f = open("ga_output.dat", 'r')
file_name = "ga_output.dat"
# initialisation and settings finishe here

def file_len(fname):
    with open(fname) as f:
        for i, l in enumerate(f):
            pass
    return i + 1


for i in range(file_len(file_name)):
    line = f.readline()
    line = re.findall("\d+\.\d+", line)

    # print(line)

    max.append(float(line[0]))
    min.append(float(line[1]))
    mean.append(float(line[2]))


f.close()

max = np.array(max)
min = np.array(min)
mean = np.array(mean)

# print(max, min, mean)
# print(max.shape, min.shape, mean.shape)

fig, ax = plt.subplots(figsize=(10,6))
ax.plot(max_xs, max, c='r', label='max')
ax.plot(min_xs, min, c='g', label='min')
ax.plot(mean_xs, mean, c='b', label='mean')
ax.set_title("Fitness over Time for Standard Simple GA")
ax.set_xlim([0, 1000])
ax.set_ylim([0, 1])
ax.set_xlabel('generation')
ax.set_ylabel('fitness')
ax.legend()
plt.show()
