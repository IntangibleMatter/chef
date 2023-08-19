extends DummyState

var player : Player

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


func dummy_walkto(position: Vector2, delta: float) -> void:
	var posdiff : Vector2 = position - player.position

	player.velocity.x += player.FORCE_ACCELERATION * sign(posdiff.x) * delta
	player.velocity.x = lerpf(player.velocity.x, player.SPEED_MAX_RUN * sign(player.velocity.x), player.FORCE_FRICTION)

