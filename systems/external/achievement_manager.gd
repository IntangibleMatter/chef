extends Node

var achiever : AchievementInterface

func _ready() -> void:
	# Determine correct interface using... build tags?
	if OS.has_feature("steam"):
		achiever = SteamAchievementInterface.new()
