extends Node2D

var sub
var piano
var kick
var rim
var hihat

# Called when the node enters the scene tree for the first time.

func _ready():
	doAudioStart()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $MakeshiftTimer.get_playback_position() > 12:
		doAudio()

	
func doAudio():
	for i in get_children():
		i.volume_db = 0
		i.playing = false
	$MakeshiftTimer.play()
	piano = randi_range(0,5)
	if piano == 0:	
		$Piano1.play()
	elif piano == 1:
		$Piano1.play()
		$PianoChords.play()
	elif piano == 2:
		$Piano2.play()
		$PianoChords.play()
	elif piano == 3:
		$Piano1.volume_db = -3
		$Piano2.volume_db = -3
		$Piano1.play()
		$Piano2.play()
		$PianoChords.play()
	elif piano == 4:
		$PianoChords.play()
	sub = randi_range(0,3)
	if sub > 0:
		$Sub.play()
	rim = randi_range(0,3)
	if rim > 0:
		$Rim1.play()
		$Rim2.play()
	kick = randi_range(0,3)
	if kick > 0:
		$Kick.play()
	hihat = randi_range(0,3)
	if hihat > 0:
		$Hihat.play()

func doAudioStart():
	$MakeshiftTimer.play()
	$Piano1.play()
	$PianoChords.play()
	$Sub.play()
	$Rim1.play()
	$Rim2.play()
	$Kick.play()
	$Hihat.play()
