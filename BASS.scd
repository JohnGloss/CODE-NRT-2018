( // - start of code

SynthDef.new( \bassLong, {
	arg amp=0.01, inputFreq=1, filterEnvStart = 2000;
	var env = EnvGen.ar(Env(
		[0, 1, 0],
		[0.05, 4],
		[1, 5]),
	    doneAction:2);
	// two stereo square waves, 2nd is one octave higher
	var squareWave = {Pulse.ar(
		freq: inputFreq + rand(0.02)-0.01,
		width: 0.5 + rand(0.2)-0.1)
	}!2;
	var squareWave2 = {Pulse.ar(
		freq: (inputFreq * 2) + rand(0.2)-0.1,
		width: 0.5 + rand(0.4)-0.2)
	}!2;
	// both waves are filtered, 2nd is also gently pulsed
	var filterEnv = XLine.kr(filterEnvStart,200,0.5);
	var filteredWave1 = LPF.ar(squareWave, filterEnv);
	var filteredWave2 = LPF.ar(squareWave2, filterEnv, mul: LFPar.kr(freq:1,iphase:0));
	var finalWave = (filteredWave1*0.7) + (filteredWave2*0.3) * env * amp;
	Splay.kr(Out.ar(0, finalWave), spread:0.9);
}).add;

~filterEnvStart = PatternProxy(2000); // init with default 2000
(
~playBassLongF = Pbind(
	\instrument, \bassLong,
	\dur, 8,
	\inputFreq, Pseq([29.midicps, 28.midicps], inf),   // Notes F and E
	\filterEnvStart, ~filterEnvStart
);
)


) // - end of code














