// MAIN CONTROLLER

(  // STEP 1: LOAD BUFFERS, CHANGE PATHNAME IF NECESSARY
~audioSources = Array.new;
~folder = PathName.new("C:/Users/johngoestouni/Desktop/SuperCollider/MY PROJECT CODE/AUDIO SOURCE FILES");
~folder.entries.do({
	arg path;
	~audioSources = ~audioSources.add(Buffer.read(s, path.fullPath))
});
~hiHatClosedBuffer = ~audioSources[0];
~hiHatOpenBuffer = ~audioSources[1];
~bassDrumBuffer = ~audioSources[2];
)

// STEP 2: (a) OPEN EVERY FILE (b) CLICK IN FILE (c) EVAL(ctrl-enter)

( // STEP 3: INITIALIZE SYSTEM
~masterAmplitude = 1;
t = TempoClock(120/60).permanent_(true);
~hiHatC = ~playHiHatClosed.asEventStreamPlayer;
~hiHatO = ~playHiHatOpen.asEventStreamPlayer;
~bassDrum = ~playBassDrum.asEventStreamPlayer;
~bass = ~playBass.asEventStreamPlayer;
~organ = ~playOrgan.asEventStreamPlayer;
)

// STEP 4: HANDLE INSTRUMENTS AS DESIRED

(  // START INSTRUMENTS
~hiHatC.play(t, quant:4); ~hiHatO.play(t, quant:8); ~bassDrum.play(t, quant:8);
~verbMix.source = 0.1;
~bass.play(t, quant:8);
~bassFilterEnvStart.source = 1; // start with attack part of Bass off
~organ.play(t, quant:8);
~organFilterEnvStart.source = 1; // start with filter completely down
)

// MODIFY INSTRUMENTS
~bassFilterEnvStart.source = 2000;  // BASS - bring full bass sound into mix
~organFilterEnvStart.source = 10000; // ORGAN - bring full bass sound into mix
~verbMix.source = Prand([0.1,0.2,0.3,0.4], inf);// HI HATS - add random reverb to closed HiHats




