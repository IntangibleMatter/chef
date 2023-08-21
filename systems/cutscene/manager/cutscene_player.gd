extends CutsceneSystemClass
class_name CutscenePlayer


## Array which all the labels in the current cutscene are stored in. Each label
## is a different element in the array, and their names can be found with.
var cutscene : Array[PackedStringArray]

## mwahaha they're passed by reference rather than value!
var actors : Dictionary = CutsceneManager.actors
var dummies : Dictionary = CutsceneManager.dummies

var current_label_brace_groups : PackedVector2Array = []

var label_index := 0
var index := 0

# flag set when the cutscene player reaches an end command
var end := false


func load_cutscene(cut: String) -> void:
	reset_label_data()
	CutsceneManager.refresh_actors()
#	cutscene_labels.clear()
	cutscene.clear()
	var temp_split : PackedStringArray = cut.split("~", false)
	for label in temp_split:
		var label_split : PackedStringArray = label.split("\n", false)
#		cutscene_labels.append(label_split.pop_front().strip_edges())
		cutscene.append(label_split)
	

#	label_index = cutscene_labels.find("start")
	label_index = find_label("start")
	cutscene_loop()


func cutscene_loop() -> void:
	# TODO: figure out where to increase index to avoid off by one errors
	# when changing labels
	# handle all the index stuff here
	while continue_cutscene():
		parse_current_item()
	end_scene()


func parse_current_item() -> void:
	var args: Array = convert_string_to_args(cutscene[label_index][index])
	var type : String = str(args.pop_front())
	var should_await : bool = type == "await"

	if should_await:
		type = str(args.pop_front())

	match type:
		"-":
			handle_dialogue(args)
		"opt":
			handle_opt(args)
		">":
			jump_to(args)
		"if":
			handle_if(args)
		"wait":
			handle_wait(args)
		"signal":
			handle_signal(args)
		"set":
			handle_set(args)
		"move":
			if should_await:
				await handle_move(args)
			else:
				handle_move(args)
		"walkto":
			if should_await:
				await handle_walkto(args)
			else:
				handle_walkto(args)
		"setpos":
			handle_setpos(args)
		"match":
			handle_match(args)
		"cam":
			cam_parser(args)
		"}", ";":
			# do nothing
			pass
	index += 1

#######################
## UTILITY FUNCTIONS ##
#######################

func validate_actor(actor: String, dummy = false) -> bool:
	if not dummy:
		if actors.has(actor):
			return is_instance_valid(actors[actor])
	else:
		if dummies.has(actor):
			return is_instance_valid(dummies[actor])
	CutsceneManager.refresh_actors()
	return false

func convert_string_to_args(item: String) -> Array:
	var args := []
	var tokenized : PackedStringArray = tokenize(item)
#	var parens : PackedVector2Array = get_item_paren_groups(tokenized)
	for token in tokenized:
		# This code will throw some errors. Unavoidable, if it doesn't crash it's fine.
		var expr := Expression.new()
		var err := expr.parse(token)
		if err != OK:
			args.append(token)
			continue
		var val : Variant = expr.execute([], self)
		if expr.has_execute_failed():
			args.append(token)
			continue
		args.append(val)

	return args


func tokenize(item: String) -> PackedStringArray:
	var tokens : PackedStringArray = []
	var in_string : bool = false
	var in_parens : bool = false
	var constructing_var : bool = false
	var curr_item: String = ""
	var curr_item_complete : bool = false
	var exclude_current : bool = false
	for i in item.length():
		if in_string:
			curr_item += item[i]
			if item[i] == "\"" and not item[i - 1] == "\\":
				in_string = false
				tokens.append(curr_item.replace("\\", ""))
				curr_item = ""
			continue
		elif in_parens:
			var j := tokens.size()
			while j > 0:
				j -= 1
				curr_item.insert(0, tokens[j])
				if tokens[j].ends_with("("):
					tokens.resize(j)
					in_parens = false
					break
			
			tokens.resize(j)
			tokens.append(curr_item)
			continue
		elif constructing_var:
			if curr_item == "":
				curr_item += "$"
			if item[i] == " ":
				tokens.append(str(handle_variable(curr_item)))
				curr_item = ""
				constructing_var = false
				continue
			curr_item += item[i]
			continue
		match item[i]:
			"\"":
				in_string = true
			"(":
				curr_item_complete = true
			")":
				in_parens = true
				curr_item_complete = true
			"$":
				constructing_var = true
				curr_item_complete = true
				exclude_current = true
			",":
				curr_item_complete = true
				exclude_current = true
			"@":
				curr_item += "handle_"
				exclude_current = true
			" ":
				curr_item_complete = true
		if not exclude_current:
			curr_item += item[i]
		if curr_item_complete:
			tokens.append(curr_item)
			#tokens.append(item[i])
			curr_item = ""
			curr_item_complete = false
			exclude_current = false
	
	return tokens


func handle_variable(item: String) -> Variant:
	var item_split : PackedStringArray = item.replace("$", "").split(".", false)
	if item_split.size() == 1:
		return Data.save_get(item)
	match item_split[0]:
		"obj":
			pass
	return null


func find_label(label: String) -> int:
	for cut in cutscene.size():
		if cutscene[cut][0] == label:
			return cut
	return -1


func continue_cutscene() -> bool:
	if index > cutscene[label_index].size():
		return false
	elif end:
		return false
	return true


func get_current_label_brace_groups() -> void:
	var label_items : PackedStringArray = cutscene[label_index]
	for item in label_items.size():
		if label_items[item].begins_with("}"):
			var j = item
			while j >= 0:
				var skip := false
				for k in current_label_brace_groups:
					if j == k.x:
						skip = true
				if not skip:
					if label_items[j].ends_with("{"):
						current_label_brace_groups.append(Vector2(j, item))
				j -= 1


func get_item_paren_groups(item: PackedStringArray) -> PackedVector2Array:
	var groups: PackedVector2Array = []
	
	for i in item.size():
		if item[i].ends_with(")"):
			var j = i
			while j >= 0:
				var skip := false
				for k in groups:
					if j == k.x:
						skip = true
					if not skip:
						if item[j].ends_with("("):
							groups.append(Vector2(j, i))
				j -= 1
	#sort to make it easier to use later
	var sorted : Array = Array(groups)
	sorted.sort_custom(func(a: Vector2, b: Vector2): return a.y - a.x < b.y - b.x)
	return PackedVector2Array(sorted)


func reset_label_data() -> void:
	current_label_brace_groups.clear()
	index = 0
	get_current_label_brace_groups()

#######################
## HANDLER FUNCTIONS ##
#######################

func handle_dialogue(args: Array) -> void:
	pass


func handle_opt(args: Array) -> void:
	pass


func jump_to(args: Array) -> void:
	var next_label := find_label(str(args[0]))
	if next_label == -1:
		end_scene()
		return
	label_index = next_label
	reset_label_data()
	pass


func handle_if(args: Array) -> void:
	pass


func handle_wait(args: Array) -> void:
	pass


func handle_signal(args: Array) -> void:
	pass


## Inputs: [actor: String, position: Vector2]
func handle_setpos(args: Array) -> void:
	if not validate_actor(args[0]): return
	
	var actor = actors[args[0]]

	if actor.has_property("global_position"):
		actor.global_position = args[1]
  

func handle_set(args: Array) -> void:
	pass

## Inputs: [actor: String, position: Vector2, time: float]
func handle_move(args: Array) -> void:
	if not validate_actor(args[0]): return

	var actor = actors[args[0]]
	
	if not actor.has_property("global_position"): return
	
	var tween = get_tree().create_tween()
	tween.tween_property(actor, "global_position", args[1], args[2])
	await tween.finished

## Inputs: [actor: String, position: Vector2, timeout: float = 3.0]
func handle_walkto(args: Array) -> void:
	if not validate_actor(args[0], true): return
	
	var dummy = dummies[args[0]]

	if not dummy.has_method("walkto"): return
	
	if args.size() < 3:
		args[2] = 3.0 # default timeout
	await dummy.walkto(args[1], args[2])



func handle_match(args: Array) -> void:
	pass


func end_scene() -> void:
	if find_label("end") == -1:
		# handle scene end
		pass
	else:
		jump_to(PackedStringArray([">", "end"]))
		index = 0
		for i in cutscene[label_index].size() - 1:
			parse_current_item()
			index = i

#######################
##   CAM FUNCTIONS   ##
#######################

func cam_parser(args: Array) -> void:
	var type : String = str(args.pop_front())
	match type:
		"move":
			cam_handle_move(args)
		"follow":
			cam_handle_follow(args)


func cam_handle_move(args: Array) -> void:
	pass


func cam_handle_follow(args: Array) -> void:
	pass


