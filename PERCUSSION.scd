// PERCUSSION

// load buffers (change pathway if necessary)
~audioSources = Array.new(50);
~folder = PathName.new("C:/Users/johngoestouni/Desktop/SuperCollider/MY PROJECT CODE/CODE-NRT-2018/AUDIO SOURCE FILES");
"Number of audio files loaded: ".post; ~folder.entries.size.postln; ~folder.entries.postln;
~folder.entries.do({
	arg path;
	~audioSources = ~audioSources.add(Buffer.read(s, path.fullPath))
});
~hiHatClosedBuffer = ~audioSources[0];
~hiHatOpenBuffer = ~audioSources[1];
~bassDrumBuffer = ~audioSources[2];

SynthDef.new( \hiHatClosed, {
	arg buf=0, amp=~masterAmplitude, verbMix=0.3, verbRoom=0.2;
	var env = EnvGen.ar(Env.perc, doneAction:2);
	var sig = PlayBuf.ar(2, buf) * env * amp;
	var verby = FreeVerb2.ar(sig[0], sig[1], mix:verbMix, room:verbRoom, damp:1);
	Out.ar(0, verby);
}).add;

~hiHatClosed=Pbindef(\patternHHC,
	\instrument, \hiHatClosed,
	\buf, ~hiHatClosedBuffer,
	\MySequence, ~hhCSeq1,
	\dur, 1/4,
	\amp, ~sixteenthPulse,
	\verbMix, ~verbMix,
);

SynthDef.new( \hiHatOpen, {
	arg buf=0, amp=~masterAmplitude, verbMix=0.3, verbRoom=0.3;
	var env = EnvGen.ar(Env([1,0],[0.25]), doneAction:2);
	var sig = PlayBuf.ar(2, buf) * env * amp;
	var verby = FreeVerb2.ar(sig[0], sig[1], mix:verbMix, room:verbRoom, damp:1);
	Out.ar(0, verby);
}).add;

~hiHatOpen = Pbindef(\patternHHO,
	\instrument, \hiHatOpen,
	\buf, ~hiHatOpenBuffer,
	\MySequence, ~hhOSeq1,
	\dur, 1/4
);

SynthDef.new( \bassDrum, {
	arg buf=0, amp=~masterAmplitude, verbMix=0.1, verbRoom=0.1;
	var env = EnvGen.ar(Env([2,0],[1]), doneAction:2);
	var sig = PlayBuf.ar(2, buf) * env * amp;
	var verby = FreeVerb2.ar(sig[0], sig[1], mix:verbMix, room:verbRoom, damp:1);
	Out.ar(0, verby);
}).add;

~bassDrum = Pbindef(\patternBD,
	\instrument, \bassDrum,
	\buf, ~bassDrumBuffer,
	\MySequence, ~bassDrumSeq1,
	\dur, 1
);

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
)
