extends Control

var levels = []
var file
var dir
var j
var button


# Called when the node enters the scene tree for the first time.
func _ready():
	dir = DirAccess.open("res://Levels/")
	dir.list_dir_begin()
	j = 0
	while true:
		j += 1
		file = dir.get_next()
		if file == "":
			break
		else:
			levels.append(load("res://Levels/" + file))
	
	for i in range(len(levels)):
		button = Button.new()
		if i > get_parent().maxLevel:
			button.disabled = true
			button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
			button.icon = load("res://resources/Lock.png")
		else:
			button.text = str(i + 1)
		button.custom_minimum_size = Vector2(65,30)
		button.theme = load("res://resources/ButtonTheme.tres")
		button.pressed.connect(load_level_function.bind(levels[i], i + 1))
		$CenterContainer/GridContainer.add_child(button)

func load_level_function(scene: PackedScene, level):
	add_sibling(scene.instantiate())
	queue_free()
	get_parent().currentLevel = level

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
