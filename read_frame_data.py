import matplotlib.pyplot as plt
import numpy as np
import re
import os

data_files = os.listdir("/home/ziqi/Desktop/collected_data_191109")
for each in data_files:
	file_info = each.split("_")
	if breathing not in file_info:
# fp = open("sample_data.txt", "r+")
text_content = fp.readlines()
fp.close()

data_frames = []

for data_line in text_content:
	if ("{" not in data_line) and ("}" not in data_line):
		continue
	else:
		data_points = re.split(",|{|}", data_line.strip())[2:-2]
		data_points = [float(data_points[i]) for i in range(0, len(data_points))]
		real = [data_points[i] for i in range(0, len(data_points)) if i % 2 == 0]
		imag = [data_points[i] for i in range(0, len(data_points)) if i % 2 == 1]
		complex_tuples = list(zip(real, imag))
		data_points = [complex(each[0], each[1]) for each in complex_tuples]
		data_frames.append(data_points)

plt.figure()
plt.xticks(np.arange(0, 2.5, step=0.1))

# sample_data = data_frames[500]
# sample_data_amp = [abs(each) for each in sample_data]
# plt.plot(np.arange(0, 2.5, step=0.05), sample_data_amp)

plt.show()