class_name Attack
extends Resource

# Change to more generic type???
enum ACTION {JUMP, DUCK, STEP}

enum DAMAGE_TYPES { NORMAL, WATER, FIRE, ELEC, CRUSHING }

@export var readable_name : String 

@export var timing_window : float = 0.3

@export var action_type : ACTION

@export_subgroup("damage")

@export var max_damage : int = 1

@export var damage_type : DAMAGE_TYPES = DAMAGE_TYPES.NORMAL

@export_subgroup("repeat")

@export var repeatable : bool = false

@export var max_repeats : int = 3

@export var repeat_damage_decrease : float = 0.25

