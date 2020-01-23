from scipy import signal
import matplotlib.pyplot as plt
import numpy as np
from select_certain_distance import select_certain_distance_bin


if __name__ == "__main__":

    sampling_rate = 23.328e9
    bb_sampling_rate = sampling_rate / 8.0
    light_speed = 299792458
    rf_interval = light_speed / 23.328e9 / 2
    bb_interval = rf_interval * 8
    slow_time_sampling_rate = 1000.0

    dataset = np.load("uwb_audio_dataset.npy", allow_pickle=True)
    dataset = dataset.item()
    data = select_certain_distance_bin(dataset, freq=110.00, bin_num=33)
    # data = data[0:6000]
    data = np.abs(data[0:6000])
    data = (data - min(data)) / (max(data) - min(data))
    data = data - np.mean(data)
    plt.figure()
    plt.plot(data)
    f, t, Zxx = signal.stft(data, slow_time_sampling_rate, window="hamming", nperseg=200)
    import pdb; pdb.set_trace();
    plt.figure()
    plt.pcolormesh(t, f[10:], np.abs(Zxx)[10:, :])
    plt.title('STFT Magnitude')
    plt.ylabel('Frequency [Hz]')
    plt.xlabel('Time [sec]')
    plt.show()
    print("NESL is awesome!")
