extends CharacterBody2D

var speed = 1000
var dirs = []
var move = false
var wallCheckers = []
var phasable = []
var phaseMode = false
var inSwitcher = 0
var inMenu = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	$CollisionShape2D.shape.size = Vector2(128 * (scale[0] + (1 - scale[0])/3 * 2.5)   ,128 * (scale[0] + (1 - scale[0])/3 * 2.5))
	$Area2D2/CollisionShape2D.shape.size = Vector2(120 * (scale[0] + (1 - scale[0])/3 * 2.5),120 * (scale[0] + (1 - scale[0])/3 * 2.5))
	if Input.is_action_just_pressed("menu") and inMenu == false:
		inMenu = true
		add_child(load("res://Scenes/OverLay.tscn").instantiate())
	elif Input.is_action_just_pressed("menu") and inMenu == true:
		if has_node("Overlay"):
			$Overlay.queue_free()
			inMenu = false
	if not inMenu:
		if Input.is_action_just_pressed("respawn"):
			respawn()
		
		dirs = []
		move = false
		if Input.is_action_pressed("right"):
			dirs.append(90)
			move = true
		elif Input.is_action_pressed("left"):
			dirs.append(270)
			move = true
		if Input.is_action_pressed("up"):
			dirs.append(0)
			move = true
		elif Input.is_action_pressed("down"):
			dirs.append(180)
			move = true
		
		if move == true:
			movement()
		
		wallCheckers = [$Checker1.is_colliding(),$Checker2.is_colliding(),$Checker3.is_colliding(),$Checker4.is_colliding()]
		
		
		if Input.is_action_just_pressed("phase"):
			if wallCheckers[0]:
				if wallCheckers[1]:
					if Input.is_action_pressed("right"):
						phase(1)
				elif wallCheckers[3]:
					if Input.is_action_pressed("up"):
						phase(0)
			elif wallCheckers[2]:
				if wallCheckers[1]:
					if Input.is_action_pressed("down"):
						phase(2)
				elif wallCheckers[3]:
					if Input.is_action_pressed("left"):
						phase(3)
		
		if $Area2D.has_overlapping_bodies():
			force_update_transform()
			$Area2D.force_update_transform()
			if len($Area2D.get_overlapping_bodies()) > inSwitcher:
				inSwitcher += 1
				phase(false)
		elif inSwitcher > 0:
			inSwitcher = 0
		if $Area2D2.has_overlapping_bodies():
			add_child(load("res://Scenes/OverLayDone.tscn").instantiate())
			inMenu = true
			if get_parent().get_parent().currentLevel > get_parent().get_parent().maxLevel:
				get_parent().get_parent().maxLevel += 1
				
	

func average(array):
	var average = 0
	for i in array:
		if 270 in array and i == 0:
			average += 360
		else:
			average += i
	average /= len(array)
	return average

func movement():
	var moved = Vector2.UP.rotated(deg_to_rad(average(dirs))) * speed
	velocity = moved
	move_and_slide()

func phase(dir):
	phaseMode = not phaseMode
	get_parent().get_child(1).visible = not get_parent().get_child(1).visible
	get_parent().get_child(2).visible = not get_parent().get_child(2).visible
	if collision_mask == 5:
		collision_layer = 6
		collision_mask = 6
	else:
		collision_layer = 5
		collision_mask = 5
	var toMove = 128 * scale[0] / 2 + 128 * (scale[0] - 0.1) / 2 + 1
	if typeof(dir) == 2:
		if dir == 0:
			position += Vector2.UP * toMove
		elif dir == 1:
			position += Vector2.RIGHT * toMove
		elif dir == 2:
			position += Vector2.DOWN * toMove
		elif dir == 3:
			position += Vector2.LEFT * toMove
		scale -= Vector2.ONE * 0.1
	if $Checker1.collision_mask == 1:
		$Checker1.collision_mask = 2
		$Checker2.collision_mask = 2
		$Checker3.collision_mask = 2
		$Checker4.collision_mask = 2
	else:
		$Checker1.collision_mask = 1
		$Checker2.collision_mask = 1
		$Checker3.collision_mask = 1
		$Checker4.collision_mask = 1

	if scale < Vector2.ONE * 0.1:
		respawn()
	

		
	

func respawn():
	scale = Vector2.ONE
	position = Vector2.ZERO
	if phaseMode:
		phase(false)
	inMenu = false
