@tool
@icon( "res://GUI/dislog_system/icons/text_bubble.svg" )
class_name DialogText extends DialogItem

@export_multiline var text : String = "Placeholder text" : set = _set_text



func _set_text( value : String ) -> void:
	text = value
	pass
