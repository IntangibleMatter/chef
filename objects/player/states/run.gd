extends PlayerState

func enter(_msg: Dictionary = {}) -> void:
	if player.jump_buffer_timer > 0:
		state_machine.transition_to("Air", {"jump": true})


func handle_input(event: InputEvent) -> void:
	pass


func physics_update(delta: float) -> void:
	player.coyote_timer = player.FRAMES_COYOTE
	if not player.is_on_floor():
		state_machine.transition_to("Air")

	if Input.is_action_just_pressed("player_jump"):
		print("ADSASD")
		state_machine.transition_to("Air", {"jump": true})
	
	var direction := Input.get_action_strength("player_right") - Input.get_action_strength("player_left")

	if direction == 0:
		player.velocity.x = lerpf(player.velocity.x, 0, player.FORCE_FRICTION)
		if is_equal_approx(player.velocity.x, 0):
			player.last_speed_x = 0
#	elif sign(direction) != sign(player.velocity.x):
#		if abs(player.last_speed_x) > 0:
#			player.velocity.x = lerpf(player.velocity.x, 0, player.FORCE_FRICTION_TURNING)
#		if abs(player.velocity.x) < 0.2 * player.last_speed_x:
#			player.velocity.x = -player.last_speed_x * player.TURNAROUND_SPEED_REGAIN
	else:
		player.velocity.x += player.FORCE_ACCELERATION * direction * delta

	

	if abs(player.velocity.x) > player.SPEED_MAX_RUN:
		player.velocity.x = lerpf(player.velocity.x, player.SPEED_MAX_RUN * sign(player.velocity.x) , player.FORCE_FRICTION)
	
	if player.velocity.x == 0:
		state_machine.transition_to("Idle")
	
	player.move_and_slide()
