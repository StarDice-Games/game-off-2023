extends Node

@export var num_players = 8
@export var bus = "Sfx"
@export var mute = false

var available = []  # The available players.
#TODO fix how the queue is managed
var queue = []  # The queue of sounds to play.


func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_players:
		var p = AudioStreamPlayer.new()
		p.connect("finished", _on_stream_finished)
		p.bus = bus
		add_child(p)
		available.append(p)


func _on_stream_finished():
	# When finished playing a stream, make the player available again.
#	available.append()
	pass


#func play(sound_path):
#	queue.append(sound_path)

func play(sound : AudioStream):
	if sound != null:
		queue.append(sound)

func _process(delta):
	# Play a queued sound if any players are available.
	if not queue.is_empty():
		var notPlaying = available.filter(isStreamStopped)
		if not notPlaying.is_empty():
			var player = notPlaying.pop_front()
			player.stream = queue.pop_front()
			if Global.sfxMuted:
				player.volume_db = -80
			else:
				player.volume_db = 0
			player.play()

func isStreamStopped(player):
	return not player.playing
