( // - start of code

SynthDef.new(\chords, {
	arg amp=~masterAmplitude-0.4, midi=0, filterEnvStart=10000;
	var envSize=1;
	var env = EnvGen.ar(Env(
		[0, 1, 0],
		[0.05, envSize],
		[-200, 5]),
	    doneAction:2);
	var wave1 = {LFTri.ar(freq: midi.midicps + rand(0.02)-0.01) };
	var filterEnv = XLine.kr(filterEnvStart,200,envSize);
	var filteredWave1 = LPF.ar(wave1, filterEnv);
	wave1 = wave1 * env * amp;
	Splay.kr(Out.ar(0, wave1), spread:1);
}).add;

~playChords=Pbind(
	\instrument, \chords,
	\amp, ~masterAmplitude,
	\dur, 8,
	\midinote, Ptuple([     // Fmaj7 and Em7
		Pseq([65,65], 1),
		Pseq([69,67], 1),
		Pseq([72,71], 1),
		Pseq([76,74], 1), inf])
	    // ? (Pseq([[65,69,72,76], [64,67,71,74]],inf)) // Fmaj7 and Em7
);

) // - end of code
