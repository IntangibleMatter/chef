class_name DummyState
extends State

func _ready() -> void:
	CutsceneManager.cutscene_signal.connect(handle_cutscene_signal.bind())
	owner.add_to_group("actor")
	owner.add_to_group("dummy")
	dummyinit()

func dummyinit() -> void:
	pass

func handle_cutscene_signal(_sig: Dictionary) -> void:
	pass
