class_name GameTimer
extends Node

var subs : int = 0
var secs : int = 0

var _prev_msec : int = 0

@export var enabled : bool = false

func mod_time() -> void:
	if subs >= 1000:
		secs += subs - subs % 1
		subs = subs % 1000


func get_formatted_time() -> String:
	mod_time()
	@warning_ignore("integer_division")
	var h : int = secs / 3600 - secs % 3600
	@warning_ignore("integer_division")
	var m : int = floor(secs/60) % 60
	var s : int = secs % 60
	@warning_ignore("integer_division")
	var ms : int = _prev_msec / 10
	var out : String = ""
	if h > 0:
		out += str(h) + ":" + str(m).pad_zeros(2) + ":"
	elif m > 0:
		out += str(m) + ":"
	out += str(s) + "." + str(ms).pad_zeros(3)
	
	return out


func get_formatted_time_split_ms() -> PackedStringArray:
	return get_formatted_time().split(".")


func _process(delta: float) -> void:
	var ms := Time.get_ticks_msec()
	
	subs = ms - _prev_msec

	_prev_msec = ms
	mod_time()

