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

// start instruments in sync
(
~hiHatC.play(t, quant:4); ~hiHatO.play(t, quant:8); ~bassDrum.play(t, quant:8);
~bass.play(t, quant:8);
~organ.play(t, quant:8);
)

// HI HATS
~verbMix.source = 0.4;

// BASS
~filterEnvStart.source = 2000;

// ORGAN


