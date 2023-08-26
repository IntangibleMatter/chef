extends Node

signal event(data: Dictionary)

signal skip_cutscene


func emit_event(data: Dictionary) -> void:
	emit_signal("event", data)


func emit_skip_cutscene() -> void:
	emit_signal("skip_cutscene")


