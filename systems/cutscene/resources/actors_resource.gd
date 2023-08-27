class_name ActorsResource
extends Resource

## Contains *every actor in the game*. Should be in {String: Actor} format.
var actors : Dictionary

"""
var actors: Array[Actor]

## THIS SHOULD NOT BE SET, THIS IS ONLY TO ACCESS ACTORS
var actor_index: PackedStringArray

func _init() -> void:
	actor_index.clear()
	actor_index.resize(actors.size())
	for actor in actors.size() -1:
		actor_index[actor] = actors[actor].name
"""
