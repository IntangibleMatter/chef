extends PlayerState


func enter(msg: Dictionary = {}) -> void:
	if msg.has("jump"):
		if msg.has("super"):
			player.velocity.y = -player.FORCE_JUMP_SUPER
		else:
			player.velocity.y = -player.FORCE_JUMP

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("player_jump"):
		player.jump_buffer_timer = player.FRAMES_JUMP_BUFFER


func physics_update(delta: float) -> void:
	player.coyote_timer -= 1
	player.jump_buffer_timer -= 1
	
	if Input.is_action_just_pressed("player_jump") and player.coyote_timer > 0:
		player.velocity.y = -player.FORCE_JUMP
		player.coyote_timer = 0
	
	var grav_multiplier : float = 1.0 if player.velocity.y < 0 else player.GRAVITY_MULTIPLIER
	if Input.is_action_pressed("player_down"):
		grav_multiplier = player.GRAVITY_MULTIPLIER_FASTFALL
	player.velocity.y += player.gravity * grav_multiplier * delta
