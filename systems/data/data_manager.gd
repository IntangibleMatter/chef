extends Node

var savefile_name : String = "save{0}.sav"

var savedata := SaveData.new()


func load_save(save_index: int) -> void:
	savedata.load_file(savefile_name.format(save_index))


func save_game(save_index: int) -> void:
	savedata.save_file(savefile_name.format(save_index))


func save_set(key: String, value: Variant) -> void:
	savedata.set_var(key, value)


func save_get(key: String) -> Variant:
	return savedata.get_var(key)
