extends StudioBankLoader

@export var even : EventAsset

var pause : EventInstance
var mus_vol : Bus

func _ready() -> void:
	pause = RuntimeManager.create_instance_path("snapshot:/pause_game")
	mus_vol = FMODStudioModule.get_studio_system().get_bus("bus:/music")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		print(';asdkj')
		var inst := RuntimeManager.create_instance_id("event:/obj/veg/cuke/cukeattacktest")
		print(inst)
		RuntimeManager.attach_instance_to_node(inst, self)
		print(RuntimeManager.attached_instances)
		inst.start()
	if event.is_action_pressed("ui_left"):
		pause.start()
	elif event.is_action_pressed("ui_right"):
		pause.stop(0)
	if event.is_action_pressed("ui_page_up"):
		if not mus_vol.get_volume().volume >= 1:
			mus_vol.set_volume(mus_vol.get_volume().volume + 0.1)
	elif event.is_action_pressed("ui_page_down"):
		if not mus_vol.get_volume().volume <= 0:
			mus_vol.set_volume(mus_vol.get_volume().volume - 0.1)
