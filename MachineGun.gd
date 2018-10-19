extends "res://tanks/Tank.gd"

onready var parent = get_parent()

func _ready():
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius


	

func _process(delta):
	
	if target:
		print("target aquired")
		var target_dir = (target.global_position - global_position).normalized()
		var current_dir = Vector2(1,0).rotated($Turret.global_rotation)
		#print (current_dir)
		$Turret.global_rotation = current_dir.linear_interpolate(target_dir, turret_speed * delta).angle()
		if target_dir.dot(current_dir) > 0.9:
			print  ("shooting")
			shoot()

func _on_DetectRadius_body_entered(body):
	print("entered")
	if body.name == "Player":
		print ("target aquired")
		target = body


func _on_DetectRadius_body_exited(body_id, body, body_shape, area_shape):
	if target == body:
		target = null


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
#	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass




func _on_DetectRadius_body_shape_exited(body_id, body, body_shape, area_shape):
	pass # replace with function body
