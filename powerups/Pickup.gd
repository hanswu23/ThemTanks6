extends Area2D

enum Items {health, ammo, power}

export (Items) var type = Items.health
export (Vector2) var ammount = Vector2(10,25)


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Pickup_body_entered(body):
	print ("pickup item type")
	print (type)
	if body.has_method('heal'):
		body.heal(int(rand_range(ammount.x,ammount.y)))
	match type:
		Items.health:
			print ("Found Health")
			if body.has_method('heal'):
				body.heal(int(rand_range(ammount.x,ammount.y)))
		Items.ammo:
			print ("Found ammo")
			pass
		Items.power:
			print ("Found power")
			if body.has_method('cannon_powerup'):
				cannon_powerup(ammount.x,ammount.y)
	print ("Found queue free")
	queue_free()
	