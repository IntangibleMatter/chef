extends CutsceneSystemClass
class_name CutscenePlayerManager

# when we *finallY* get typed dicts, this'll be a String:Node relationship.
var actors : Dictionary

# Dicts are passed by reference so I don't need to worry about updating children.
func poll_actors() -> void:
	var possible_actors := get_tree().get_nodes_in_group("actor")
	var add_to_pool := func(identifier: String, actor: Node) -> void:
		actors[identifier] = actor
	
	for act in possible_actors:
		if act.has_method("add_self_to_cutscene_manager"):
			act.connect("add_actor", add_to_pool)
			act.add_self_to_cutscene_manager()


func add_cutscene(scene: Cutscene) -> void:
	match scene.text_type:
		0: # Embedded text
			pass
		1: # Exterenal file
			pass

