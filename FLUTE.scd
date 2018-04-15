( // - start of code

SynthDef(\flute, { arg bus = 0, fluteBuffer = 0, rateScale;
	var envSize=0.4;
	var pitchAdjustment = rateScale * 0.5;
	var env = EnvGen.ar(Env(
		[0, 1, 0],
		[0.05, envSize],
		[-200, 5]),
	    doneAction:2);
	var sig = PlayBuf.ar(2, fluteBuffer, BufRateScale.kr(fluteBuffer) * pitchAdjustment);
	var enveloped = sig * env;
	Splay.kr(Out.ar(0, enveloped));
}).add;

~playFlute = Pbind(
	\instrument, \flute,
	\bus, 0,
	\fluteBuffer, ~fluteE,
	\dur, Pseq([1], inf),
	\rateScale, Pseq([
		Pseq([1.0833,1.6664], 4),
		Pseq([1,1.5831], 4)
	], inf);
)

) // - end of code

//Fmaj7: 1.0833,1.4165,1.6664,2
//Emin7: 1,1.2499,1.5831,1.833