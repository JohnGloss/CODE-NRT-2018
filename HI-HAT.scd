( // - start of code

// RHTYHM SEQUENCES ( "0" is trigger, "\" is rest
~hhCSeq1 =  Pseq([ Pseq([0,\,0,0], 3), Pseq([0,0,0,0], 1)], inf);
~hhOSeq1 =    Pseq([
	Pseq([\,\,\,\], 6),
	Pseq([\,\,0,\], 1),
	Pseq([\,\,Prand([0,\],1),\], 1),
], inf);
~bassDrumSeq1 =  Pseq([ Pseq([0,\,\,\,], 3), Pseq([0,\,0,0], 1)], inf);

// AMPLITUDE SEQUENCES
~sixteenthPulse = Pseq(([10,5,7,3]/100), inf);

// SYNTH DEFs
SynthDef.new( \hiHatClosed, {
	arg buf=0, amp=~masterAmplitude, verbMix=0.3, verbRoom=0.2;
	var env = EnvGen.ar(Env.perc, doneAction:2);
	var sig = PlayBuf.ar(2, buf) * env * amp;
	var verby = FreeVerb2.ar(sig[0], sig[1], mix:verbMix, room:verbRoom, damp:1);
	Out.ar(0, verby);
}).add;

SynthDef.new( \hiHatOpen, {
	arg buf=0, amp=~masterAmplitude, verbMix=0.3, verbRoom=0.3;
	var env = EnvGen.ar(Env([1,0],[0.25]), doneAction:2);
	var sig = PlayBuf.ar(2, buf) * env * amp;
	var verby = FreeVerb2.ar(sig[0], sig[1], mix:verbMix, room:verbRoom, damp:1);
	Out.ar(0, verby);
}).add;

SynthDef.new( \bassDrum, {
	arg buf=0, amp=(~masterAmplitude+0.5), verbMix=0.1, verbRoom=0.1;
	var env = EnvGen.ar(Env.perc, doneAction:2);
	var sig = PlayBuf.ar(2, buf) * env * amp;
	var verby = FreeVerb2.ar(sig[0], sig[1], mix:verbMix, room:verbRoom, damp:1);
	Out.ar(0, verby);
}).add;

// PBINDs
~verbMix = PatternProxy(0.3); // init with default 0.3
~playHiHatClosed = Pbind(
	\instrument, \hiHatClosed,
	\buf, ~hiHatClosedBuffer,
	\MySequence, ~hhCSeq1,
	\dur, 1/4,
	\amp, ~sixteenthPulse,
	\verbMix, ~verbMix
);

~playHiHatOpen = Pbind(
	\instrument, \hiHatOpen,
	\buf, ~hiHatOpenBuffer,
	\MySequence, ~hhOSeq1,
	\dur, 1/4
);

~playBassDrum = Pbind(
	\instrument, \bassDrum,
	\buf, ~bassDrumBuffer,
	\MySequence, ~bassDrumSeq1,
	\dur, 1
);

) // - end of code














