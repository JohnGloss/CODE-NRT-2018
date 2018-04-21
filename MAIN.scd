// MAIN CONTROLLER

Execution steps:
1.  Eval all files except MAIN (this file)
2.  In this file (MAIN), (a) Start the clock, (b) Start Instruments, (c) Modify Instruments and FX
-- if you need to stop the instruments, start the clock before starting the instruments

// Start clock
t = TempoClock(120/60).permanent_(true);

(  // START INSTRUMENTS
~masterAmplitude = 1;
~bass.play(t, quant:8);
~hiHatClosed.play(t, quant:4);
~hiHatOpen.play(t, quant:4);
~bassDrum.play(t, quant:4);
~organ.play(t, quant:8);
~chords.play(t, quant:8);
~synthFlute.play(t, quant:8);
)

// MODIFY INSTRUMENTS, as desired
Pbindef(\bassPattern,\filterStart, 3000);    // attack part of BASS
Pbindef(\organPattern,\filterStart, 10000);  // ORGAN volume (controlled by filter)
Pbindef(\chordPattern,\chordsAmpl, 0.3);     // CHORDS volume
Pbindef(\flutePattern,\fluteAmpl, 0.15);     // FLUTE volume
Pbindef(\patternHHC,\verbMix, Prand([0.1,0.2,0.3], inf));// add random reverb to closed HiHats

// MODIFY FX, as desired
~panner=Synth.new(\sineModulator, [inBus:~organBus, outBus:~organBusFX]);
~panner.set(\amp, 1);
~panner.set(\modFreq, 333);
~panner.free;