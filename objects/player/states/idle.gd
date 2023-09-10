extends PlayerState


func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("player_jump"):
		state_machine.transition_to("Air", {"jump": true})
	
	if Input.is_action_pressed("player_left") or Input.is_action_pressed("player_right"):
		state_machine.transition_to("Run")
	
	if Input.is_action_just_pressed("player_attack"):
		state_machine.transition_to("RunAttack")

func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")


func enter(_msg := {}) -> void:
	print(state_machine)


func exit() -> void:
	pass
