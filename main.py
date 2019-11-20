import matplotlib.pyplot as plt
import numpy as np
from read_frame_data import read_uwb_data

sampling_rate = 23.328e9
bb_sampling_rate = sampling_rate/8.0
light_speed = 299792458
rf_interval = light_speed/23.328e9/2
bb_interval = rf_interval * 8
slow_time_sampling_rate = 1000.0

# read the audio-UWB dataset
try:
    uwb_audio_dataset = np.load("uwb_audio_dataset.npy")
except FileNotFoundError:
    filepath = "../collected_data/collected_data_191109"
    uwb_audio_dataset = read_uwb_data(filepath)
    np.save("uwb_audio_dataset.npy", uwb_audio_dataset)
# The next step is to perform data collection

# The next step is find the "range of interest", i.e. locate the speaker
    # Ziqi's proposal: Calculate the phase and amplitude of each distance, and then calculate variance of them

# The next step is to plot the phase and amplitude over time, and perform STFT on them


print("NESL is awesome!")
