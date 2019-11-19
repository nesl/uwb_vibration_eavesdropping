import matplotlib.pyplot as plt
import numpy as np

sampling_rate = 23.328e9
bb_sampling_rate = sampling_rate/8.0
light_speed = 299792458
rf_interval = light_speed/23.328e9/2
bb_interval = rf_interval * 8

slow_time_sampling_rate = 1000.0


def select_certain_distance_bin(uwb_audio_dataset:dict, freq=440.00, bin_num=25):
    select_fast_slow_time = uwb_audio_dataset[freq][1]
    # dist = 0.75
    # bin_to_load = np.round((dist - rf_interval*4) / bb_interval) + 1
    bb_data_slow_time_at_selected_bin = []
    for i in range(0, len(select_fast_slow_time)):
        bb_data_slow_time_at_selected_bin.append(select_fast_slow_time[i][bin_num])
    return bb_data_slow_time_at_selected_bin


def select_certain_distance_bin_breath(uwb_breath_dataset:dict, testee="a", bin_num=25):
    select_fast_slow_time = uwb_breath_dataset[testee]
    # dist = 0.75
    # bin_to_load = np.round((dist - rf_interval*4) / bb_interval) + 1
    bb_data_slow_time_at_selected_bin = []
    for i in range(0, len(select_fast_slow_time)):
        bb_data_slow_time_at_selected_bin.append(select_fast_slow_time[i][bin_num])
    return bb_data_slow_time_at_selected_bin


if __name__ == "__main__":
    # dataset = np.load("uwb_audio_dataset.npy")
    # dataset = dataset.item()
    #
    # phase_variance_over_distances = []
    # phase_mean_over_distances = []
    # amp_variance_over_distances = []
    # amp_mean_over_distances = []
    #
    # for i in range(0, 49):
    #     bb_data_slow_time = select_certain_distance_bin(dataset, freq=220.00, bin_num=i)
    #     bb_data_slow_time_amp = [abs(each) for each in bb_data_slow_time]
    #     bb_data_slow_time_phase = [np.angle(each) for each in bb_data_slow_time]
    #     phase_variance_over_distances.append(np.var(bb_data_slow_time_phase))
    #     phase_mean_over_distances.append(np.mean(bb_data_slow_time_phase))
    #     amp_variance_over_distances.append(np.var(bb_data_slow_time_amp))
    #     amp_mean_over_distances.append(np.mean(bb_data_slow_time_amp))
    #
    # plt.figure()
    # plt.plot(amp_mean_over_distances)
    # plt.figure()
    # plt.plot(amp_variance_over_distances)
    # plt.figure()
    # plt.plot(phase_mean_over_distances)
    # plt.figure()
    # plt.plot(phase_variance_over_distances)
    #
    # bb_data_slow_time = select_certain_distance_bin(dataset, freq=110.00, bin_num=25)
    # # plot the phase and amplitude
    #
    # bb_data_slow_time_amp = [abs(each) for each in bb_data_slow_time]
    # bb_data_slow_time_phase = [np.angle(each) for each in bb_data_slow_time]
    # plt.figure()
    # plt.xticks(np.arange(1/1000.0, (len(bb_data_slow_time)+1)/1000.0, step=1/1000.0))
    # plt.plot(np.arange(1/1000.0, (len(bb_data_slow_time)+1)/1000.0, step=1/1000.0), bb_data_slow_time_amp)
    # plt.figure()
    # plt.xticks(np.arange(1/1000.0, (len(bb_data_slow_time)+1)/1000.0, step=1/1000.0))
    # plt.plot(np.arange(1/1000.0, (len(bb_data_slow_time)+1)/1000.0, step=1/1000.0), bb_data_slow_time_phase)
    # plt.show()

    dataset = np.load("uwb_breath_dataset.npy")
    dataset = dataset.item()

    phase_variance_over_distances = []
    phase_mean_over_distances = []
    amp_variance_over_distances = []
    amp_mean_over_distances = []

    for i in range(0, 49):
        bb_data_slow_time = select_certain_distance_bin_breath(dataset, testee="b", bin_num=i)
        bb_data_slow_time_amp = [abs(each) for each in bb_data_slow_time]
        bb_data_slow_time_phase = [np.angle(each) for each in bb_data_slow_time]
        phase_variance_over_distances.append(np.var(bb_data_slow_time_phase))
        phase_mean_over_distances.append(np.mean(bb_data_slow_time_phase))
        amp_variance_over_distances.append(np.var(bb_data_slow_time_amp))
        amp_mean_over_distances.append(np.mean(bb_data_slow_time_amp))

    plt.figure()
    plt.plot(amp_mean_over_distances)
    plt.figure()
    plt.plot(amp_variance_over_distances)
    plt.figure()
    plt.plot(phase_mean_over_distances)
    plt.figure()
    plt.plot(phase_variance_over_distances)

    # bb_data_slow_time = select_certain_distance_bin_breath(dataset, testee="a", bin_num=30)
    # # plot the phase and amplitude
    #
    # bb_data_slow_time_amp = [abs(each) for each in bb_data_slow_time]
    # bb_data_slow_time_phase = [np.angle(each) for each in bb_data_slow_time]
    # plt.figure()
    # plt.xticks(np.arange(1 / 1000.0, (len(bb_data_slow_time) + 1) / 1000.0, step=1 / 1000.0))
    # plt.plot(np.arange(1 / 1000.0, (len(bb_data_slow_time) + 1) / 1000.0, step=1 / 1000.0), bb_data_slow_time_amp)
    # plt.figure()
    # plt.xticks(np.arange(1 / 1000.0, (len(bb_data_slow_time) + 1) / 1000.0, step=1 / 1000.0))
    # plt.plot(np.arange(1 / 1000.0, (len(bb_data_slow_time) + 1) / 1000.0, step=1 / 1000.0), bb_data_slow_time_phase)
    plt.show()
