extends "res://tanks/Tank.gd"


onready var parent = get_parent()






func _ready():
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius

func control(delta):
	if $LookAhead1.is_colliding() or $LookAhead2.is_colliding():
		speed = lerp(speed,0,0.1)
	else:
		speed = lerp(speed,max_speed,0.1)
	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + speed * delta)
		position = Vector2(0,0)
	else:
		pass
	

func _process(delta):
	
	if target:

		var target_dir = (target.global_position - global_position).normalized()
		var current_dir = Vector2(1,0).rotated($Turret.global_rotation)
		#print (current_dir)
		$Turret.global_rotation = current_dir.linear_interpolate(target_dir, turret_speed * delta).angle()
		if target_dir.dot(current_dir) > 0.9:
			shoot(target)

func _on_DetectRadius_body_entered(body):

	if body.name == "Player":

		target = body


func _on_DetectRadius_body_shape_exited(body_id, body, body_shape, area_shape):
	if target == body:
		target = null
