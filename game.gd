extends Node

var curr_scene : Node
var current_scene_path : String

signal scene_spawned(scene: String)

func change_scene(scene: String, msg : Dictionary = {}) -> void:
	# TODO: This should be moved to a thread, to avoid lag spikes. Shouldn't be too much of an issue.
	var scn : Node
	
	if FileAccess.is_path_valid(scene):
		scn = load(scene).instantiate()
	else:
		return
	
	if curr_scene_hold.get_child_count() > 0:
		for child in curr_scene_hold.get_children():
			child.queue_free()
	
	curr_scene_hold.add_child(scn)
	curr_scene = scn
	current_scene_path = scene

	print(scn)

