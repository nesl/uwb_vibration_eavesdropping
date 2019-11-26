import re
import os
import matplotlib.pyplot as plt
import numpy as np

def read_uwb_data(filepath):
	data_files = os.listdir(filepath)
	uwb_data = {}
	for filename in data_files:
		file_info = filename.split("_")
		if "breathing" not in file_info:

			audio_frequency = int(file_info[0]) + 0.01 * int(file_info[1])

			fp = open(filepath + "/" + filename, "r+")
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

			if audio_frequency not in uwb_data.keys():
				uwb_data[audio_frequency] = []
			uwb_data[audio_frequency].append(data_frames)
			print("Loaded data of audio frequency {}, Count {}.".format(audio_frequency, len(uwb_data[audio_frequency])))
	print("Reading data done.")
	return uwb_data


def read_breath_data(filepath):
	data_files = os.listdir(filepath)
	uwb_data = {}
	for filename in data_files:
		file_info = filename.split("_")
		if "breathing" in file_info:

			testee = file_info[1]
			# distance = file_info[2]

			fp = open(filepath + "/" + filename, "r+")
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

			if testee not in uwb_data.keys():
				uwb_data[testee] = data_frames
			print("Loaded data of testee {}.".format(testee))
	print("Reading data done.")
	return uwb_data

# # plot the phase and amplitude
# plt.figure()
# plt.xticks(np.arange(0, 2.5, step=0.1))

# sample_data = data_frames[500]
# sample_data_amp = [abs(each) for each in sample_data]
# plt.plot(np.arange(0, 2.5, step=0.05), sample_data_amp)

# plt.show()


if __name__ == "__main__":
	#breath_data = read_breath_data("/home/ziqi/Desktop/collected_data_191109")
	breath_data = read_breath_data("../collected_data/collected_data_191109")
	try:
		uwb_audio_dataset = np.load("uwb_breath_dataset.npy")
	except FileNotFoundError:
		np.save("uwb_breath_dataset.npy", breath_data)
	print("NESL is awesome.")
