// MAIN CONTROLLER

(  // STEP 1: LOAD BUFFERS, CHANGE PATHNAME IF NECESSARY
~audioSources = Array.new(50);
~folder = PathName.new("C:/Users/johngoestouni/Desktop/SuperCollider/MY PROJECT CODE/AUDIO SOURCE FILES");
~folder.entries.size.postln; ~folder.entries.postln;
~folder.entries.do({
	arg path;
	~audioSources = ~audioSources.add(Buffer.read(s, path.fullPath))
});
~hiHatClosedBuffer = ~audioSources[0];
~hiHatOpenBuffer = ~audioSources[1];
~bassDrumBuffer = ~audioSources[2];
~fluteE = ~audioSources[3];
~fluteF = ~audioSources[4];
~fluteG = ~audioSources[5];
~fluteA = ~audioSources[6];
~fluteB = ~audioSources[7];
~fluteC = ~audioSources[8];
~fluteD = ~audioSources[9];
~fluteE_high = ~audioSources[10];
~fluteF_high = ~audioSources[11];
)

// STEP 2: (a) OPEN EVERY FILE (b) CLICK IN FILE (c) EVAL(ctrl-enter)

( // STEP 3: INITIALIZE SYSTEM (system clock, streams)
~masterAmplitude = 1;
t = TempoClock(120/60).permanent_(true);
~hiHatC = ~playHiHatClosed.asEventStreamPlayer;
~hiHatO = ~playHiHatOpen.asEventStreamPlayer;
~bassDrum = ~playBassDrum.asEventStreamPlayer;
~bass = ~playBass.asEventStreamPlayer;
~organ = ~playOrgan.asEventStreamPlayer;
~chords = ~playChords.asEventStreamPlayer;
)

// STEP 4: HANDLE INSTRUMENTS AS DESIRED

(  // START INSTRUMENTS
~hiHatC.play(t, quant:4); ~hiHatO.play(t, quant:8); ~bassDrum.play(t, quant:8);
~verbMix.source = 0.1;
~bass.play(t, quant:8);
~bassFilterEnvStart.source = 1; // start with attack part off
~organ.play(t, quant:8);
~organFilterEnvStart.source = 1; // start with filter completely down
~chords.play(t, quant:8);
~chordsAmpl.source = 0.0; // start with volume off
)

// MODIFY INSTRUMENTS
~bassFilterEnvStart.source = 2000;   // BASS - bring bass attack into mix
~organFilterEnvStart.source = 10000; // ORGAN - bring rest of sound into mix
~chordsAmpl.source = 0.1;           // CHORDS - bring full sound into mix
~verbMix.source = Prand([0.1,0.2,0.3], inf);// HI HATS - add random reverb to closed HiHats



