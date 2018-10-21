extends "res://tanks/Tank.gd"

onready var parent = get_parent()

func _ready():
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius


	

func _process(delta):
	
	if target:
		var target_dir = (target.global_position - global_position).normalized()
		var current_dir = Vector2(1,0).rotated($Turret.global_rotation)
		#print (current_dir)
		$Turret.global_rotation = current_dir.linear_interpolate(target_dir, turret_speed * delta).angle()
		if target_dir.dot(current_dir) > 0.9:
			shoot()

func _on_DetectRadius_body_entered(body):
	print("entered")
	if body.name == "Player":
		target = body


func _on_DetectRadius_body_sha_exited(body_id, body, body_shape, area_shape):
    pass

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







func _on_DetectRadius_body_exited(body):
	if target == body:
		target = null
	
