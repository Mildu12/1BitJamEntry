extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "PHASES LEFT	: " + str(abs(round(10 * get_parent().get_parent().get_child(0).scale[0] - 2)))
