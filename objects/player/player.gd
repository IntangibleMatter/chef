class_name Player
extends CharacterBody2D

const FORCE_JUMP : float = -400.0
const FORCE_JUMP_SUPER : float = -600.0

const FORCE_ACCELERATION : float = 256.0
const SPEED_MAX_RUN : float = 96.0
const FORCE_FRICTION : float = 0.4

const GRAVITY_MULTIPLIER : float = 1.2
const GRAVITY_MULTIPLIER_FASTFALL : float = 1.4

const SPEED_BOOST_ATTACK : float = 30.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


# frame countdowns
const FRAMES_JUMP_BUFFER : int = 10
const FRAMES_COYOTE : int = 10

var jump_buffer_timer : int = 0
var coyote_timer : int = 0


var last_speed_X : float = 0


@onready var anim: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var sprite: Sprite2D = $Sprite2D
