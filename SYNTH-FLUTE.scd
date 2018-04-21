(  // SYNTH FLUTE

~synthFluteBus=54;
~synthFluteBusFX=60; ~synthFluteBusFXPlayer = {Out.ar(0, In.ar(~synthFluteBusFX, 2))}.play;

SynthDef(\synthFlute, { arg fluteAmpl=0, inputFreq = 0;
	var envSize=0.2;
	var env = EnvGen.ar(Env(
		[0, fluteAmpl, 0],
		[0.05, envSize],
		[1, 44]),
	    doneAction:2);
	var wave1 = {
		LFTri.ar( freq: inputFreq + rand(0.02)-0.01)
	}!2;
	var filterEnv = XLine.kr(3000,200,envSize);
	var filteredWave1 = LPF.ar(wave1, filterEnv);
	var finalWave = filteredWave1 * env * 0.4;
	Out.ar(~synthFluteBus, finalWave);  // SEND TO SYNTH-FLUTE BUS
	Splay.kr(Out.ar(0, finalWave), spread:1);
}).add;

Pbindef(\flutePattern,\fluteAmpl, 0);

~synthFlute=Pbindef(\flutePattern,
	\instrument, \synthFlute,
	\fluteAmpl, 0,
	\dur, Pseq([0.25], inf),
	\inputFreq, Pseq([
		Pseq([65,69,72,69,65,69,72,76], 4),
		Pseq([64,67,71,67,64,67,71,74], 4)],
	inf).midicps;// Fmaj7 and Em7 chords
);
) 