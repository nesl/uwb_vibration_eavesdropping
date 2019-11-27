import numpy as np
import simpleaudio as sa
import scipy.io.wavfile as save_wav

C = 130.82
D = 146.83
E = 164.81
F = 174.61
G = 196
A = 220
B = 246.94

long_note = 0.9
short_note = 0.5

emptiness = np.zeros(4410)

def create_note(time1, freq):
	frequency = freq  # Our played note will be 440 Hz
	fs = 44100  # 44100 samples per second
	seconds = time1  # Note duration of 3 seconds

	# Generate array with seconds*sample_rate steps, ranging between 0 and seconds
	t = np.linspace(0, seconds, seconds * fs, False)

	# Generate a 440 Hz sine wave
	note = np.sin(frequency * t * 2 * np.pi)

	# Ensure that highest value is in 16-bit range
	audio = note * (2**15 - 1) / np.max(np.abs(note))
	# Convert to 16-bit data
	audio = audio.astype(np.int16)

	# # Start playback
	# play_obj = sa.play_buffer(audio, 1, 2, fs)

	# # Wait for playback to finish before exiting
	# play_obj.wait_done()

	return audio


sound = []

sound = np.asarray(sound)

sound = np.append(sound, create_note(short_note, E))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, D))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, C))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, D))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, E))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, E))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(long_note, E))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, D))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, D))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(long_note, D))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, E))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, G))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(long_note, G))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, E))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, D))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, C))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, D))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, E))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, E))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(long_note, E))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, D))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, D))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, E))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(short_note, D))
sound = np.append(sound, emptiness)
sound = np.append(sound, create_note(long_note, C))


save_wav.write('mary_has_a_little_lamb.wav', 44100, sound)
