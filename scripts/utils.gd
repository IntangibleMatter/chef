extends Node


func freeze_frame(scale : float = 0.1, time : float = 0.2) -> void:
	Engine.time_scale = scale * Settings.accessibility.time_scale
	await get_tree().create_timer(time * scale * Settings.accessibility.time_scale).timeout
	Engine.time_scale = Settings.accessibility.time_scale
