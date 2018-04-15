( // - start of code

SynthDef(\flute, { arg fluteAmpl=0, bus = 0, inputFreq = 0;
	var envSize=0.2;
	var env = EnvGen.ar(Env(
		[0, fluteAmpl, 0],
		[0.05, envSize],
		[1, 44]),
	    doneAction:2);
	var wave1 = {LFTri.ar(
		freq: (inputFreq * 0.99) + rand(0.02)-0.01)
	}!2;
	var wave2 = {LFTri.ar(
		freq: (inputFreq * 1.01) + rand(0.2)-0.1)
	}!2;
	var filterEnv = XLine.kr(3000,200,envSize);
	var filteredWave1 = LPF.ar(wave1, filterEnv);
	var filteredWave2 = LPF.ar(wave2, filterEnv);
	var finalWave = (filteredWave1*0.5) + (filteredWave2*0.5) * env;
	Splay.kr(Out.ar(0, finalWave), spread:1);
}).add;

~fluteAmpl = PatternProxy(0.0);
~playFlute = Pbind(
	\instrument, \flute,
	\bus, 0,
	\fluteAmpl, ~fluteAmpl,
	\dur, Pseq([0.25], inf),
	\inputFreq, Pseq([
		Pseq([65,69,72,69,65,69,72,76], 4),
		Pseq([64,67,71,67,64,67,71,74], 4)],
	inf).midicps;// Fmaj7 and Em7 chords
)

) // - end of code

