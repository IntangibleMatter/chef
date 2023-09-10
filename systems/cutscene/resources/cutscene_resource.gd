class_name Cutscene_DEPRECATED
extends Resource

## So, this was better a while back, but I decided that to make everybody's
## (read: my) lives easier, I'd just make it so all the actors are in one giant
## Dict loaded on launch. Bit of a performance hit but I doubt that'll be an
## issue. If it is, well fuck me I guess. Refactoring is future Lyric's problem.
## And, at the time of writing this, I'm present Lyric. Fuck that future guy.
## Well, no, that's inaccurate and a bit mean. I hope he's doing well :) Hey
## girl, how're you feeling, is she certain she's trans yet? If you are I'm sorry
## for deadnaming you if that's not your actual name now. Uhhh... yeah, anyways.
## Cutscenes are loaded as plain-text .cut files. End of story.
##
## tl;dr Write your cutscenes in files that end with [code].cut[/code]

"""
enum CUTSCENE_FROM { TEXT, FILE }

@export var characters : Array[Actor]

@export_subgroup("Contents")
@export var text_type : CUTSCENE_FROM = CUTSCENE_FROM.TEXT
## Can be used as either the text which the cutscene is built from, or the path
## to a text file which the cutscene is built from. Base on the parameter above.
@export_multiline var contents : String
""" 
