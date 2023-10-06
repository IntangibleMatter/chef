class_name Player
extends CharacterBody2D

const FORCE_JUMP : float = -450.0
const FORCE_JUMP_RELEASE : float = -128.0
#const FORCE_JUMP_SUPER : float = -600.0

const FORCE_ACCELERATION : float = 512.0
const FORCE_ACCELERATION_AIR : float = 400.0
const FORCE_ACCELERATION_AIR_TURNAROUND : float = 400.0

const SPEED_MAX_RUN : float = 196.0
const SPEED_MAX_AIR : float = 500.0

const FORCE_FRICTION : float = 0.4
const FORCE_FRICTION_TURNING : float = 0.6
const FORCE_FRICTION_AIR : float = 0.4
const FORCE_FRICTION_AIR_SPEEDCAP : float = 0.2
const TURNAROUND_SPEED_REGAIN : float = 0.6

const GRAVITY_MULTIPLIER : float = 1.2
const GRAVITY_MULTIPLIER_FASTFALL : float = 1.4

const SPEED_BOOST_ATTACK : float = 30.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


# frame countdowns
const TIME_JUMP_BUFFER : int = 0.266
const TIME_COYOTE : int = 0.116
const TIME_ATTACK_COOLDOWN : float = 0.15

var jump_buffer_timer : float = 0
var coyote_timer : float = 0
var attack_cooldown_timer : float = 0

var last_speed_x : float = 0


@onready var anim: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var sprite: Sprite2D = $Sprite2D
