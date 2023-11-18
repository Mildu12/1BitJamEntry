extends Button

var music_bus = AudioServer.get_bus_index("Master")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_down():
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))
	print(button_pressed)
