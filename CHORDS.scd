( // - start of code

SynthDef.new(\chords, {
	arg amp=0.1, freq=440, filterEnvStart=3000;
	var envSize=4;
	var env = EnvGen.ar(Env(
		[0, 0.05, 0],
		[0.05, envSize],
		[-200, 5]),
	    doneAction:2);
	var wave1 = {
		{LFPulse.ar(
			freq: freq + rand(0.02)-0.01,
			width: SinOsc.ar(1, 0, 0.1))}!4
	};
	var filterEnv = XLine.kr(filterEnvStart,200,envSize);
	var filteredWave1 = LPF.ar(wave1, filterEnv) * env * (amp*0.5);
	var verby = FreeVerb.ar(filteredWave1, mix:0.5, room:0.4, damp:1)!2;
	Splay.kr(Out.ar(0, verby), spread:1);
}).add;

~playChords=Pbind(
	\instrument, \chords,
	\amp, ~masterAmplitude,
	\dur, 8,
	\freq, Ptuple([ // Fmaj7 and Em7 chords
		Pseq([65,64]),
		Pseq([69,67]),
		Pseq([72,71]),
		Pseq([76,74]),
	], inf).midicps
);

) // - end of code
