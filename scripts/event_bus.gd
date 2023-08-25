extends Node

signal event(data: Dictionary)


func emit_event(data: Dictionary) -> void:
	emit_signal("event", data)
