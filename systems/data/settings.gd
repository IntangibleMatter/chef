extends Node

const CFG_FILE_NAME := "user://chef.cfg"
const SETTINGS_NAME := "settings"
const ACCESSIBILITY_NAME := "accessibility"
const CONTROLS_NAME := "controls"

var settings : Dictionary = {
	"fullscreen": true,
	"vol_mus": 1.0,
	"vol_sfx": 1.0,
}

var accessibility : Dictionary = {
	"time_scale": 1.0,
	"damage_scale": 1.0,
	"screenshake": 1.0,
}

func save_settings() -> void:
	var cfg := ConfigFile.new()

	for setting in settings:
		cfg.set_value(SETTINGS_NAME, setting, settings[setting])
	
	for setting in accessibility:
		cfg.set_value(ACCESSIBILITY_NAME, setting, accessibility[setting])
	
	for action in InputMap.get_actions():
		cfg.set_value(CONTROLS_NAME, action, InputMap.action_get_events(action))
	
	cfg.save(CFG_FILE_NAME)


func load_settings() -> void:
	var cfg = ConfigFile.new()

	var err : Error = cfg.load(CFG_FILE_NAME)
	
	if err != OK:
		save_settings()
		return
	
	for setting in cfg.get_section_keys(SETTINGS_NAME):
		settings[setting] = cfg.get_value(SETTINGS_NAME, setting)
	
	for setting in cfg.get_section_keys(ACCESSIBILITY_NAME):
		accessibility[setting] = cfg.get_value(ACCESSIBILITY_NAME, setting)

	# Probably bad practice to delete all the inputs before loading, but w/e, it avoids any duplication glitches
	for action in InputMap.get_actions():
		InputMap.action_erase_events(action)

	for action in cfg.get_section_keys(CONTROLS_NAME):
		if not InputMap.has_action(action):
			InputMap.add_action(action)
		
		for event in cfg.get_value(CONTROLS_NAME, action):
			InputMap.action_add_event(action, event)
	

