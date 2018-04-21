(  // BUS FX

SynthDef(\sineModulator, { arg inBus = 0, outBus = 0, modFreq = 1, amp = 0;
	var modulator = SinOsc.kr(freq:[modFreq-0.05, modFreq+0.5], mul:Line.kr(0,1,8));
	var carrier = In.ar(inBus, 1);
	var signal = carrier * modulator * amp;
	Splay.kr(Out.ar(outBus, signal), spread:1);
}).add;

SynthDef(\phasingTremelo, { arg inBus=0, outBus=0, amp=0, modFreq=1, modOffset=0.01;
	var modulator = LFCub.kr(
		freq:[modFreq-modOffset, modFreq+modOffset],
		mul:Line.kr(0,1,8));
	var carrier = In.ar(inBus, 1);
	var signal = carrier * modulator * amp;
	Splay.kr(Out.ar(outBus, signal), spread:1);
}).add;

SynthDef(\triangleReverb, { arg inBus=0, outBus=0, amp=0, modFreq=2;
	var modulator = LFTri.kr(freq:modFreq, iphase:2, mul:Line.kr(0,1,8));
	var signal = FreeVerb.ar(
		in: {In.ar(inBus, 1)}!2,
		mix: modulator,
		room: 0.5,
		damp: 0.5)
	* amp;
	Out.ar(outBus, signal);
}).add;

SynthDef(\wavyPanner, { arg inBus=0, outBus=0, amp=0, modFreq=1, modOffset=0.001;
	var modulatorInner = LFCub.kr(
		freq:[modFreq-modOffset, modFreq+modOffset],
		mul:Line.kr(0,1,8));
	var modulator = LFCub.kr(modulatorInner);
	var carrier = In.ar(inBus, 1);
	var signal = carrier * modulator * amp;
	Splay.kr(Out.ar(outBus, signal), spread:1);
}).add;

SynthDef(\sinePhaser, { arg inBus=0, outBus=0, amp=0, modFreq=1, modOffset=0.001;
	var modulator = SinOsc.ar(
		freq: [0+modOffset, 0-modOffset],
		phase: SinOsc.ar(freq: modFreq, phase: 0),
		mul:Line.kr(0,1,8));
	var carrier = In.ar(inBus, 1);
	var signal = carrier * modulator * amp;
	Splay.kr(Out.ar(outBus, signal), spread:1);
}).add;

SynthDef(\noiseWave, { arg inBus=0, outBus=0, amp=0, modFreq=0.25, iPhase=0;
	var modulator = {LPF.ar(PinkNoise.ar(VarSaw.ar(
		modFreq,
		iphase:iPhase,
		mul:Line.kr(0,1,8)
	)),1000)}!2;
	var carrier = In.ar(inBus, 1);
	var signal = carrier * modulator * amp;
	Splay.kr(Out.ar(outBus, signal), spread:1);
}).add;

SynthDef(\crossfadeMod, { arg inBus=0, outBus=0, amp=0, modA=400, modB=200, crossFreq=0.25;
	var modulator = {XFade2.ar(
		Saw.ar(modA, mul:Line.kr(0,1,8)),
		SinOsc.ar(modB, mul:Line.kr(0,1,8)),
		LFTri.kr(crossFreq))
	}!2;
	var carrier = In.ar(inBus, 1);
	var signal = carrier * modulator * amp;
	Splay.kr(Out.ar(outBus, signal), spread:1);
}).add;

SynthDef(\simpleDelay, { arg inBus=0, outBus=0, amp=0, delayTime=0.25;
	var carrier = In.ar(inBus, 1);
	var signal = {DelayC.ar(
		in: carrier,
		maxdelaytime: 2,
		delaytime: delayTime,
		mul:Line.kr(0,1,8))
	}!2 * amp;
	Splay.kr(Out.ar(outBus, signal), spread:1);
}).add;

SynthDef(\phasingDelay, { arg inBus=0, outBus=0, amp=0, delayTime=0.25;
	var diff = delayTime/4;
	var carrier = In.ar(inBus, 1);
	var signal = {DelayC.ar(
		in: carrier,
		maxdelaytime: 2,
		delaytime: [delayTime+diff,delayTime-diff],
		mul:Line.kr(0,1,8))
	} * amp;
	Splay.kr(Out.ar(outBus, signal), spread:1);
}).add;

SynthDef(\combDelay, { arg inBus=0, outBus=0, amp=0, delayTime=0.125, decayTime=0.25;
	var carrier = In.ar(inBus, 1);
	var signal ={CombC.ar(
		in: carrier,
		maxdelaytime: 2,
		decaytime: decayTime,
		delaytime: delayTime,
		mul:Line.kr(0,1,8))
	}!2 * amp;
	Splay.kr(Out.ar(outBus, signal), spread:1);
}).add;

SynthDef(\crossoverDist, { arg inBus = 0, outBus = 0, smooth = 0.01, amp = 0.01;
	var carrier = In.ar(inBus, 1);
	var signal = { CrossoverDistortion.ar(
		in: carrier,
		amp: amp,
		smooth: smooth,
		mul: Line.kr(0,0.01,8))}!2;
	Splay.kr(Out.ar(outBus, signal), spread:1);
}).add;
)
// -----------------------------------------------------------------------------
// FX TESTING - during performance, change amp to 0 before free to avoid clicks
~panner=Synth.new(\sineModulator, [inBus:~fluteBus, outBus:~fxBus1]);
~panner.set(\amp, 0.4);
~panner.set(\modFreq, 2);
~panner.free;
~tremelo=Synth.new(\phasingTremelo, [inBus:~fluteBus, outBus:~fxBus1]);
~tremelo.set(\amp, 0.5);
~tremelo.set(\modFreq, 1);
~tremelo.set(\modOffset, 1);
~tremelo.free;
~triangleReverb=Synth.new(\triangleReverb, [inBus:~fluteBus, outBus:~fxBus1]);
~triangleReverb.set(\amp, 0.1);
~triangleReverb.free;
~wavyPanner=Synth.new(\wavyPanner, [inBus:~fluteBus, outBus:~fxBus1]);
~wavyPanner.set(\amp, 0.3);
~wavyPanner.set(\modFreq, 1);
~wavyPanner.free;
~sinePhaser=Synth.new(\sinePhaser, [inBus:~fluteBus, outBus:~fxBus1]);
~sinePhaser.set(\amp, 0.0);
~sinePhaser.set(\modFreq, 2);
~sinePhaser.free;
~noiseWave=Synth.new(\noiseWave, [inBus:~fluteBus, outBus:~fxBus1]);
~noiseWave.set(\amp, 0.3);
~noiseWave.set(\modFreq, 0.25);
~noiseWave.set(\iPhase, 0);
~noiseWave.free;
~crossfadeMod=Synth.new(\crossfadeMod, [inBus:~fluteBus, outBus:~fxBus1]);
~crossfadeMod.set(\amp, 0.1);
~crossfadeMod.set(\crossFreq, 0.25);
~crossfadeMod.set(\modA, 400);
~crossfadeMod.set(\modB, 200);
~crossfadeMod.free;
~simpleDelay=Synth.new(\simpleDelay, [inBus:~fluteBus, outBus:~fxBus1]);
~simpleDelay.set(\amp, 0.1);
~simpleDelay.set(\delayTime, 0.5); // causes clicks
~simpleDelay.free;
~phasingDelay=Synth.new(\phasingDelay, [inBus:~fluteBus, outBus:~fxBus1]);
~phasingDelay.set(\amp, 0.1);
~phasingDelay.set(\delayTime, 0.125); // causes clicks
~phasingDelay.free;
~combDelay=Synth.new(\combDelay, [inBus:~fluteBus, outBus:~fxBus1]);
~combDelay.set(\amp, 0.2);
~combDelay.set(\delayTime, 0.25); // causes clicks
~combDelay.set(\decayTime, 1);
~combDelay.free;
~crossoverDist=Synth.new(\crossoverDist, [inBus:~fluteBus, outBus:~fxBus1]);
~crossoverDist.set(\amp, 0.1); // careful when exceed 0.2
~crossoverDist.set(\smooth, 0.1); // careful when exceed 0.15
~crossoverDist.free;

// clear previous run
~panner=nil; ~tremelo=nil; ~triangleReverb=nil; ~wavyPanner=nil; ~sinePhaser=nil;
~noiseWave=nil; ~crossfadeMod=nil; ~simpleDelay=nil; ~phasingDelay=nil; ~combDelay=nil;
~crossoverDist=nil;









	