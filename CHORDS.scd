( // - start of code

SynthDef.new(\chords, {
	arg chordsAmpl=0, freq=440;
	var envSize=4;
	var env = EnvGen.ar(Env(
		[0, chordsAmpl, 0],
		[0.05, envSize],
		[-200, 5]),
	    doneAction:2);
	var wave1 = {
		{LFPulse.ar(
			freq: freq + rand(0.02)-0.01,
			width: SinOsc.ar(1, 0, 0.1))}!4
	};
	var filterEnv = XLine.kr(3000,200,envSize);
	var filteredWave1 = LPF.ar(wave1, filterEnv) * env * 0.1;
	var verby = FreeVerb.ar(filteredWave1, mix:0.5, room:0.4, damp:1)!2;
	Splay.kr(Out.ar(0, verby), spread:1);
}).add;

~chordsAmpl = PatternProxy(0.0);

~playChords=Pbind(
	\instrument, \chords,
	\chordsAmpl, ~chordsAmpl,
	\dur, 8,
	\freq, Ptuple([ // Fmaj7 and Em7 chords
		Pseq([65,64]),
		Pseq([69,67]),
		Pseq([72,71]),
		Pseq([76,74]),
	], inf).midicps,
	\chordsAmpl, ~chordsAmpl
);

) // - end of code
