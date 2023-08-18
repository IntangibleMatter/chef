extends PlayerState

func enter(msg: Dictionary = {}) -> void:
	if player.jump_buffer_timer > 0:
		player.velocity.y = -player.JUMP_FORCE if (
			player.jump_buffer_timer < player.JUMP_BUFFER_FRAMES - 4
			) else -player.SUPERJUMP_FORCE
		state_machine.transition_to("Air")


func physics_update(delta: float) -> void:
	player.coyote_timer = player.COYOTE_FRAMES
	if not player.is_on_floor():
		state_machine.transition_to("Air")
	
	if Input.is_action_just_pressed("player_jump"):
		player.velocity.y = -player.JUMP_FORCE
		state_machine.transition_to("Air")
	
	var direction := Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	
	if sign(direction) != sign(player.velocity.x):
		if abs(player.last_speed_x) > 0:
			player.velocity.x = lerpf(player.velocity.x, 0, player.FRICTION)
		if abs(player.velocity.x) < 0.2 * player.last_speed_X:
			player.velocity.x = -player.last_speed_X * 0.5
