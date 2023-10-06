extends PlayerState


func enter(_msg: Dictionary = {}) -> void:
	var attacksound: EventInstance = FMODRuntime.create_instance_path("event:/sfx/player/attack")
	FMODRuntime.attach_instance_to_node(attacksound, player)
	attacksound.start()
	player.velocity.x += player.SPEED_BOOST_ATTACK * sign(player.velocity.x)

