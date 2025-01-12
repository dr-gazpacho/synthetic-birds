SynthDef(\junco, {
	arg t_trig = 1, out = 0;
	var chirp, pitch;
	var basePitch = 2157;
	var env = EnvGen.kr(
		Env.new(
			[1, 0, 1],
			[0.1, 0],
			[-4]
		).range(1, 4),
		t_trig,
		doneAction: Done.freeSelf
	);

	pitch = (basePitch) * env;
	chirp = SinOsc.ar(pitch) ! 2 * -25.dbamp;
	chirp = chirp + (chirp * SinOsc.ar(100).range(0, 1));

	chirp = chirp * EnvGen.kr(Env.perc(0, 0.15, -3), t_trig);
	chirp = RLPF.ar(chirp, 4500, 0.5);
	Out.ar(out, chirp * 1.25.dbamp);
}).add;

~sequence = Array.fill(14, 0.09).add(3);
~loops = rrand(2, 5);

(
~junco = Pbind(
	\instrument, \junco,
	\dur, Pseq(~sequence, ~loops)
).play;
)





