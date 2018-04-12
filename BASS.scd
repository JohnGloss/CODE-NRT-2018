( // - start of code

SynthDef.new( \bassLong, {
	arg amp=0.01, squareFreq=440, filterEnvStart = 2000;
	var env = EnvGen.ar(Env(
		[0, 1, 0],
		[0.05, 4],
		[1, 5]),
	    doneAction:2);
	var squareWave = {Pulse.ar(
		freq: squareFreq + rand(0.02)-0.1,
		width: 0.5 + rand(0.2)-1)
	}!2;
	var filterEnv = XLine.kr(filterEnvStart,200,1);
	var filteredWave = LPF.ar(squareWave, filterEnv) * env * amp;
	Splay.kr(Out.ar(0, filteredWave), spread:0.9);
}).add;

~filterEnvStart = PatternProxy(2000); // init with default 2000
(
~playBassLongF = Pbind(
	\instrument, \bassLong,
	\dur, 8,
	\squareFreq, Pseq([29.midicps, 28.midicps], inf),   // Notes F and E
	\filterEnvStart, ~filterEnvStart
);
)


) // - end of code














