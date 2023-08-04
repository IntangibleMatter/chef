extends StudioBankLoader

@export var even : EventAsset

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		print(';asdkj')
		var inst := RuntimeManager.create_instance_path("event:/Sfx/Veggies/Cuke/cukeattacktest")
		print(inst)
		RuntimeManager.attach_instance_to_node(inst, self)
		print(RuntimeManager.attached_instances)
		inst.start()
		
