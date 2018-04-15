( // - start of code

SynthDef(\flute, { arg bus = 0, fluteBuffer = 0, rateScale = 1;
	var env = EnvGen.kr(Env.sine(BufDur.kr(fluteBuffer)));
	var sig = PlayBuf.ar(2, fluteBuffer, BufRateScale.kr(fluteBuffer) * rateScale) * env;
	Splay.kr(Out.ar(0, sig));
}).add;

~playFlute = Pbind(
	\instrument, \flute,
	\bus, 0,
	\fluteBuffer, ~fluteE,
	\dur, 8,
	\audioBuffer, 3  // Pseq([Prand[4,6,8,10],Prand[3,5,7,9]], inf),// numbers are buffers for chord notes
);

) // - end of code
