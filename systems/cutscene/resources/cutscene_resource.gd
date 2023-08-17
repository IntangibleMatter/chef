class_name Cutscene
extends Resource

enum CUTSCENE_FROM { TEXT, FILE }

@export var characters : Array[Character]

@export_subgroup("Contents")
@export var text_type : CUTSCENE_FROM = CUTSCENE_FROM.TEXT
## Can be used as either the text which the cutscene is built from, or the path
## to a text file which the cutscene is built from. Base on the parameter above.
@export_multiline var contents : String
 
