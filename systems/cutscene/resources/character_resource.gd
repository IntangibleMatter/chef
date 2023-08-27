class_name Actor
extends Resource

## The name of the actor.
var name : String
## The "emotions" which the character can use while talking. 
var emotions: Array[Emotion]
## The sound used for the character to speak.
var sound : EventAsset
var background : Texture

# would that this were a struct...
class Emotion:
	## The image that displays while the character is talking.
	var talking_image: Texture
	## The image that displays when the character has stopped talking.
	var still_image: Texture
	## The index of the emotion in the Fmod Event.
	var sound : int

	func _init() -> void:
		if still_image == null:
			still_image = talking_image

