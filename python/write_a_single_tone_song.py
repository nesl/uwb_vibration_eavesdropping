import numpy as np
import simpleaudio as sa
import scipy.io.wavfile as save_wav

C3 = 130.81
D3 = 146.83
E3 = 164.81
F3 = 174.61
G3 = 196
A3 = 220
B3 = 246.94
C4 = 261.63
D4 = 293.66
E4 = 329.63
F4 = 349.23
G4 = 392.00
A4 = 440
B4 = 493.88

long_note = 0.5
short_note = 0.25

emptiness = np.zeros(4410)

def create_note(time1, freq):
	frequency = freq  # Our played note will be 440 Hz
	fs = 44100  # 44100 samples per second
	seconds = time1  # Note duration of 3 seconds

	# Generate array with seconds*sample_rate steps, ranging between 0 and seconds
	t = np.linspace(0, seconds, int(seconds * fs), False)

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


# sound = []
# sound = np.asarray(sound)
# sound = np.append(sound, np.zeros(44100))
# sound = np.append(sound, create_note(6, 900))
# save_wav.write('900Hz.wav', 44100, sound)

sound = []
sound = np.asarray(sound)
sound = np.append(sound, np.zeros(44100))
sound = np.append(sound, create_note(10, C4))
save_wav.write('C4.wav', 44100, sound)

# # # The following sound is "Mary has a little lamb"
# #
# sound = []
# sound = np.asarray(sound)
# sound = np.append(sound, create_note(long_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, C4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, G4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, G4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, C4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(long_note, C4))
#
#
# save_wav.write('mary_has_a_little_lamb.wav', 44100, sound)
#
# # The following sound is "Twinkle twinkle little star"
# sound = []
# sound = np.asarray(sound)
# sound = np.append(sound, create_note(short_note, C4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, C4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, G4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, G4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, A4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, A4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, G4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, F4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, F4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, C4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, G4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, G4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, F4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, F4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, G4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, G4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, F4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, F4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, C4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, C4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, G4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, G4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, A4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, A4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, G4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, F4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, F4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, E4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, D4))
# sound = np.append(sound, emptiness)
# sound = np.append(sound, create_note(short_note, C4))
#
#
# save_wav.write('twinkle_twinkle_little_star.wav', 44100, sound)
