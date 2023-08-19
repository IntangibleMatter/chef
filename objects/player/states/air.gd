extends PlayerState


func enter(msg: Dictionary = {}) -> void:
	if msg.has("jump"):
		if player.jump_buffer_timer > 0:
			player.velocity.y = lerpf(-player.FORCE_JUMP, -player.FORCE_JUMP_SUPER, (1.0/player.FRAMES_JUMP_BUFFER * player.FRAMES_JUMP_BUFFER - player.jump_buffer_timer))
			player.jump_buffer_timer = 0
		else:
			player.velocity.y = -player.FORCE_JUMP
		player.anim.travel("jump")
	else:
		player.anim.travel("fall")

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

	player.move_and_slide()


func update(_delta: float) -> void:
	if player.velocity.y < 0:
		player.anim.travel("jump")
	else:
		player.anim.travel("fall")


