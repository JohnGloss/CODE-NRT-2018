( // - start of code

SynthDef.new(\organ, {
	arg amp=0.01, inputFreq=440, filterEnvStart=5000;
	var env = EnvGen.ar(Env(
		[0, 1, 0],
		[0.05, 1],
		[1, 1]),
	    doneAction:2);
	// Two variable-duty saw waves
	var sawWave = {VarSaw.ar(
		freq: (inputFreq * 0.99) + rand(0.02)-0.01,
		width: 0.5 + rand(0.4)-0.2)
	}!2;
	var sawWave2 = {VarSaw.ar(
		freq: (inputFreq * 1.01) + rand(0.2)-0.1,
		width: 0.5 + rand(0.3)-0.15)
	}!2;
	// both waves are filtered
	var filterEnv = XLine.kr(filterEnvStart,20,0.75);
	var filteredWave1 = LPF.ar(sawWave, filterEnv);
	var filteredWave2 = LPF.ar(sawWave2, filterEnv);
	var finalWave = (filteredWave1*0.5) + (filteredWave2*0.5) * env * amp;
	Splay.kr(Out.ar(0, finalWave), spread:0.9);

}).add;

~playOrgan=Pbind(
	\instrument, \organ,
	\dur, Pseq([1,1,1,1,1,1,1,1], inf),
	\inputFreq, Pseq([Pn(41.midicps, 8), Pn(40.midicps, 8)], inf),   // Notes F and E
);


) // - end of code





