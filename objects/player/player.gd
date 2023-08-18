class_name Player
extends CharacterBody2D

const JUMP_FORCE : float = -400.0
const SUPERJUMP_FORCE : float = -600.0

const ACCELERATION : float = 256.0
const MAX_RUN_SPEED : float = 96.0
const FRICTION : float = 0.4

const GRAVITY_MULTIPLIER : float = 1.2
const GRAVITY_MULTIPLIER_FASTFALL : float = 1.4

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


# frame countdowns
const JUMP_BUFFER_FRAMES : int = 10
const COYOTE_FRAMES : int = 10

var jump_buffer_timer : int = 0
var coyote_timer : int = 0


var last_speed_X : float = 0
