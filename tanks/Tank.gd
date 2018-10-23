extends KinematicBody2D

signal shoot
signal health_changed
signal dead

export (PackedScene) var Bullet
export (int) var max_speed
export (float) var rotation_speed
export (float) var gun_cooldown
export (int) var max_health

var velocity = Vector2()
var can_shoot = true
var alive = true
var health

export (float) var turret_speed
export (int) var detect_radius
var speed = 0
var target = null

func _ready():
	health = max_health
	emit_signal('health_changed', health * 100/max_health)
	#emit_signal('health_changed', 100)
	$GunTimer.wait_time = gun_cooldown

func control(delta):
        pass
		
func shoot(target=null):
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		var dir = Vector2(1,0).rotated($Turret.global_rotation)
		emit_signal('shoot', Bullet, $Turret/Muzzle.global_position, dir)
		$AnimationPlayer.play('muzzle_flash')
		
func _physics_process(delta):
        if not alive:
                return
        control(delta)
        move_and_slide(velocity)
		
func take_damage (amount):
	health -= amount
	emit_signal('health_changed',health * 100/max_health)
	if health <= 0:
		explode()
		print ("emit_signal dead()")
		emit_signal('dead')

func heal (amount):
	health += amount
	emit_signal('health_changed',health * 100/max_health)
	if health >= 100:
		explode()
		print ("emit_signal dead()")
		emit_signal('dead')

func _on_GunTimer_timeout():
	can_shoot = true # replace with function body
	
func explode():
	$CollisionShape2D.disabled = true
	alive = false
	$Turret.hide()
	$Body.hide()
	$Explosion.show()
	$Explosion.play()
	



func _on_Explosion_animation_finished():
	queue_free()

func _on_DetectRadius_body_entered(body):
	if body.name == "Player":
		target = body


func _on_DetectRadius_body_exited(body):
	if target == body:
		target = null

