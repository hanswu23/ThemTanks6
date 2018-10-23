extends Area2D

export (int) var speed
export (int) var damage
export (float) var lifetime
export (float) var steer_force = 0

var velocity = Vector2()
var acceleration = Vector2()
var target = null

func start(_position,_direction,_target=null):
	position = _position
	rotation = _direction.angle()
	$LifeTime.wait_time = lifetime
	print (_direction)
	print (speed)
	velocity = _direction * speed
	target = _target
	
	
func seek():
	var desired = (target.position - position).normalized * speed
	var steer = (desired - velocity).normalized * steer_force 
	return steer
	
func _process(delta):
	if target:
		acceleration += seek()
		velocity += acceleration * delta
		velocity = velocity.clamped(speed)
		rotation  = velocity.angle()
	position += velocity * delta
	
	

func _ready():
	# Called when the  node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func explode():
	velocity = Vector2()
	$Sprite.hide()
	$Explosion.show()
	$Explosion.play("smoke")
	
func _on_Explosion_animation_finished():
	queue_free()

func _on_Bullet_body_entered(body):
	explode()
	if body.has_method('take_damage'):
		body.take_damage(damage)


func _on_LifeTime_timeout():
	explode()
	 
