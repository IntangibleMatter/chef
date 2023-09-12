extends CutsceneSystemClass
#class_name CutscenePlayerManager

signal cutscene_signal(data: Dictionary)

# when we *finallY* get typed dicts, this'll be a String:Node relationship.
var actors : Dictionary
var dummies : Dictionary

var cutscenes : Array#[CutscenePlayer]

var cutscene_display : CutsceneDisplay


func _ready() -> void:
	await get_tree().process_frame
	cutscene_display = CutsceneDisplay.new()
	add_sibling(cutscene_display)

# Dicts are passed by reference so I don't need to worry about updating children.
func poll_actors() -> void:
	var possible_actors := get_tree().get_nodes_in_group("actor")
	var dummystates := get_tree().get_nodes_in_group("DummyState")
	for actor in possible_actors:
		if is_instance_valid(actor):
			actors[actor.name] = actor
			if actor.is_in_group("dummy"):
				dummies[actor.name] = get_connected_dummy(actor, dummystates)
	"""
	var add_to_pool := func(identifier: String, actor: Node) -> void:
		actors[identifier] = actor
	
	for act in possible_actors:
		if act.has_method("add_self_to_cutscene_manager"):
			act.connect("add_actor", add_to_pool)
			act.add_self_to_cutscene_manager()
	"""

func get_connected_dummy(actor: Node, new_dummies: Array[Node]) -> DummyState:
	for dummy in new_dummies:
		if dummy.owner == actor:
			return dummy
	return DummyState.new()


func clean_actor_list() -> void:
	for actor in actors:
		if not is_instance_valid(actors[actor]):
			actors.erase(actor)
			if dummies.has(actor):
				dummies.erase(actor)


func refresh_actors(total_clean : bool = false) -> void:
	if total_clean:
		actors.clear()
		dummies.clear()
	else:
		clean_actor_list()
	poll_actors()


#func add_cutscene(scene: Cutscene) -> void:
#	match scene.text_type:
#		0: # Embedded text
#			pass
#		1: # Exterenal file
#			pass


func display_dialogue_line(actor: Node, emotion: int, line: String, c_player: CutscenePlayer) -> void:
	pass


func close_dialogue(immediate: bool = false) -> void:
	pass

