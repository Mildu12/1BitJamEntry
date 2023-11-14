extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "PHAZES LEFT:" + str(round(get_parent().get_parent().get_child(0).scale[0] * 10 - 2))
