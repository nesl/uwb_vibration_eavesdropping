import matplotlib.pyplot as plt
import numpy as np
import re
import scipy.fftpack
from select_certain_distance import select_certain_distance_bin


# 15 for the reference bin


# Map the normalized amplitude to visualize and get a reference bin
def getHighestReferenceAmp(frame_vals):

	yf = frame_vals
	fig, ax = plt.subplots()
	ax.plot(yf)
	plt.show()
	return yf.index(np.max(yf))

# Get the average reference bin
def getAverageRefBin(data_frames, frame_indexes):
	avg_bin = 0

	for idx in frame_indexes:
		ref = getHighestReferenceAmp(data_frames[idx])
		avg_bin += ref
	avg_bin /= int(len(frame_indexes)) # Get int value for average ref bin

	return avg_bin


class PhaseCorrection(object):
	def __init__(self, bbframes_ref, bin_ref):
		"""Takes a baseband frame buffer and stores mean phase of the given bin.
		The phase at the reference bin is later used as a reference when
		phase correcting the frame:
		1. Calculate the difference between the reference bin phase and
		the stored reference value
		2. Adjust phase of all bins with the calculated difference
		The phase noise is correlated throughout the frame, thus correcting
		the phase of all bins compared to the reference bin, improves
		phase noise substantially.
		The reference bin must be static and should contain signal, the
		direct coupled energy in the beginning of the frame is often preferred.
		"""
		self.bin_ref = bin_ref
		self.bin_angle = np.angle(bbframes_ref[:,bin_ref]).mean()


		print(self.bin_angle)

		#self.bin_angle = np.angle([x[bin_ref] for x in bbframes]).mean()

	def filter(self, frame):
		#print(frame)
		frame_complex = [[x.real, x.imag] for x in frame]
		#print(frame_complex)
		frame_complex = np.asarray([x[0] + 1j*x[1] for x in frame_complex])
		phase_correction = self.bin_angle - np.angle(frame_complex[self.bin_ref])
		print(phase_correction)
		return frame_complex * np.exp(1j*phase_correction)


dataset = np.load("uwb_audio_dataset.npy", allow_pickle=True)
dataset = dataset.item()
bb_frames = np.array(dataset[220.00][0])
#
# frame_9_amp = [abs(each) for each in (dataset[220.00][0][9])]
# plt.figure()
# plt.plot(frame_9_amp)
# plt.show()

# Get the reference bin and the target bin
# reference_bin = select_certain_distance_bin(dataset, freq=220.00, bin_num=0)
# target_bin = select_certain_distance_bin(dataset, freq=220.00, bin_num=24)

# calculate the phase for this particular bin
pnc = PhaseCorrection(bb_frames, 0)
# Apply the filter to other pieces of data

plt.figure()
plt.plot(np.angle(bb_frames[:, 24])[0:1000])

for i in range(0, len(bb_frames)):
	bb_frames[i,:] = pnc.filter(bb_frames[i,:])

plt.figure()
plt.plot(np.angle(bb_frames[:, 24])[0:1000])
plt.show()
