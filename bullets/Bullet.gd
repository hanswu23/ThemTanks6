extends Area2D

export (int) var speed
export (int) var damage
export (float) var lifetime

var velocity = Vector2()

func start(_position,_direction):
	print ("start")
	print (lifetime)
	position = _position
	rotation = _direction.angle()
	$LifeTime.wait_time = lifetime
	velocity = _direction * speed
	
func _process(delta):
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
	#print ("explode")
	#print($LifeTime.wait_time)
	#set_process(false)
	#velocity = Vector2()
	#$Sprite.hide()
	queue_free()

func _on_Bullet_body_entered(body):
	explode()
	if body.has_method('take_damage'):
		body.take_damage(damage)


func _on_LifeTime_timeout():
	print ("_on_LifeTime_timeout")
	print (lifetime)
	print ($LifeTime.wait_time)
	explode()
	 
