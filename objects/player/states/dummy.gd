extends DummyState
var player : Player

signal walkto_done

enum DUMMYSTATES {
	IDLE,
	WALKTO,
}

var microstate : DUMMYSTATES = DUMMYSTATES.IDLE

var target : Vector2 = Vector2.ZERO

func dummyinit() -> void:
	player = owner


func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * player.GRAVITY_MULTIPLIER * delta
	
	if microstate == DUMMYSTATES.WALKTO:
		dummy_walkto(target, delta)
	
	player.move_and_slide()


func walkto(pos: Vector2, timeout: float) -> void:
	microstate = DUMMYSTATES.WALKTO
	target = pos
	get_tree().create_timer(timeout).timeout.connect(func(): emit_signal("walkto_done"))
	await walkto_done
	microstate = DUMMYSTATES.IDLE
	return


func dummy_walkto(position: Vector2, delta: float) -> void:
	var posdiff : Vector2 = position - player.position

	player.velocity.x += player.FORCE_ACCELERATION * sign(posdiff.x) * delta
	player.velocity.x = lerpf(player.velocity.x, player.SPEED_MAX_RUN * sign(player.velocity.x), player.FORCE_FRICTION)

	if position.is_equal_approx(player.global_position):
		emit_signal("walkto_done")

