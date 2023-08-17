class_name SaveData
extends Node

var savedata : Dictionary = {}


func set_var(var_name: String, data: Variant) -> void:
	savedata[var_name] = data


func get_var(var_name: String) -> Variant:
	if savedata.has(var_name):
		return savedata[var_name]
	return 0


func load_file(file: String) -> void:
	if not savedata.is_empty():
		savedata.clear()
	var config := ConfigFile.new()
	var err : int = config.load(file)
	
	if err != OK:
		create_file(file)
	
	for key in config.get_section_keys("save"):
		savedata[key] = config.get_value("save", key)


func save_file(file: String) -> void:
	var config = ConfigFile.new()
	for val in savedata:
		config.set_value("save", val, savedata[val])
	config.save(file)


func create_file(file: String) -> void:
	# Put in some other stuff which handles all the suff for a new save
	save_file(file)

