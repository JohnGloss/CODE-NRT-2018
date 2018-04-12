// MAIN CONTROLLER

(  // STEP 1: LOAD BUFFERS, CHANGE PATHNAME IF NECESSARY
~audioSources = Array.new;
~folder = PathName.new("C:/Users/johngoestouni/Desktop/NRT/SuperCollider/MY PROJECT CODE/AUDIO SOURCE FILES");
~folder.entries.do({
	arg path;
	~audioSources = ~audioSources.add(Buffer.read(s, path.fullPath))
});
~hiHatClosedBuffer = ~audioSources[0];
~hiHatOpenBuffer = ~audioSources[1];
)

// STEP 2: (a) OPEN EVERY FILE (b) CLICK IN FILE (c) EVAL(ctrl-enter)

( // STEP 3: INITIALIZE SYSTEM
t = TempoClock(120/60).permanent_(true);
~hiHatC = ~playHiHatClosed.asEventStreamPlayer;
~hiHatO = ~playHiHatOpen.asEventStreamPlayer;
~bassL = ~playBassLongF.asEventStreamPlayer;
)

// STEP 4: HANDLE INSTRUMENTS AS DESIRED

// HI HATS
(~hiHatC.play(t, quant:4); ~hiHatO.play(t, quant:4);) // START
(~hiHatC.pause; ~hiHatO.pause;) // PAUSE
(~hiHatC.resume; ~hiHatO.resume;) // RESUME
~verbMix.source = 0.4;

// BASS
~bassL.play(t, quant:4); // START
~bassL.pause; // PAUSE
~bassL.resume;  // RESUME
~filterEnv.source = 777;