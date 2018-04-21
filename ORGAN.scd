(  // ORGAN

~organBus=52;

SynthDef.new(\organ, {
	arg amp=~masterAmplitude, inputFreq=440, filterStart=1;
	var envSize=0.4;
	var env = EnvGen.ar(Env(
		[0, 1, 0],
		[0.05, envSize],
		[-200, 5]),
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
	var filterEnv = XLine.kr(filterStart,200,envSize);
	var filteredWave1 = LPF.ar(sawWave, filterEnv);
	var filteredWave2 = LPF.ar(sawWave2, filterEnv);
	var finalWave = (filteredWave1*0.5) + (filteredWave2*0.5) * env * amp;
	Out.ar(~organBus, finalWave);  // SEND TO ORGAN BUS
	Splay.kr(Out.ar(0, finalWave), spread:1);
}).add;

Pbindef(\organPattern,\filterStart, 200);

~organ=Pbindef(\organPattern,
	\instrument, \organ,
	\amp, Pseq(([10,8,4,4]/50), inf),
	\dur, Pseq([0.5,1,0.25,0.25], inf),
	\inputFreq, Pseq([Pn(41.midicps, 16), Pn(40.midicps, 16)], inf), // Notes F and E
	\filterStart, 1
);
)