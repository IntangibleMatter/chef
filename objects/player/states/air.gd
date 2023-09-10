extends PlayerState


func enter(msg: Dictionary = {}) -> void:
	player.jump_buffer_timer = 0
	if msg.has("jump"):
		player.velocity.y = player.FORCE_JUMP
		player.anim.travel("jump")
	else:
		player.anim.travel("fall")

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("player_jump"):
		player.jump_buffer_timer = player.FRAMES_JUMP_BUFFER


func physics_update(delta: float) -> void:
	player.coyote_timer -= 1
	player.jump_buffer_timer -= 1
	
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	
	if Input.is_action_just_pressed("player_jump") and player.coyote_timer > 0:
		player.velocity.y = -player.FORCE_JUMP
		player.coyote_timer = 0
	
	var grav_multiplier : float = 1.0 if player.velocity.y < 0 else player.GRAVITY_MULTIPLIER
	if Input.is_action_pressed("player_down"):
		grav_multiplier = player.GRAVITY_MULTIPLIER_FASTFALL
	player.velocity.y += player.gravity * grav_multiplier * delta

	var direction := Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	print(direction)
	
	if direction == 0:
		player.velocity.x = lerpf(player.velocity.x, 0, player.FORCE_FRICTION_AIR)
	elif sign(direction) != sign(player.velocity.x):
		if abs(player.last_speed_x) > 0:
			player.velocity.x = lerpf(player.velocity.x, 0, player.FORCE_FRICTION_)
		if abs(player.velocity.x) < 0.2 * player.last_speed_x:
			player.velocity.x = -player.last_speed_x * 0.5
	
	print(player.velocity)

	player.move_and_slide()


func update(_delta: float) -> void:
	if player.velocity.y < 0:
		player.anim.travel("jump")
	else:
		player.anim.travel("fall")


