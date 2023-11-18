extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_down():
	if get_parent().get_parent().get_parent().get_parent().get_parent().currentLevel < get_parent().get_parent().get_parent().get_parent().get_parent().levelCount:
		get_parent().get_parent().get_parent().get_parent().get_parent().add_child(load("res://Levels/Level" + str(get_parent().get_parent().get_parent().get_parent().get_parent().currentLevel + 1) + ".tscn").instantiate())
		get_parent().get_parent().get_parent().get_parent().get_parent().get_child(0).queue_free()
		get_parent().get_parent().get_parent().get_parent().get_parent().currentLevel += 1
	else:
		print("dd")
		get_parent().get_parent().get_parent().get_parent().get_parent().add_child(load("res://Levels/Level" + str(get_parent().get_parent().get_parent().get_parent().get_parent().currentLevel) + ".tscn").instantiate())
		get_parent().get_parent().get_parent().get_parent().get_parent().get_child(0).queue_free()
