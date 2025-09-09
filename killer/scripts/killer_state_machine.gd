class_name KillerStateMachine extends Node


var states : Array[ KillerState ]
var prev_state : KillerState
var current_state : KillerState

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


func _process(delta):
	change_state( current_state.process( delta ) )
	pass



func _physics_process(delta):
	change_state( current_state.physics( delta ) )
	pass



func initialize( _killer : Killer ) -> void:
	states = []
	
	for c in get_children():
		if c is KillerState:
			states.append( c )
	
	for s in states:
		s.killer = _killer
		s.state_machine = self
		s.init()
	
	if states.size() > 0:
		change_state( states[0] )
		process_mode = Node.PROCESS_MODE_INHERIT
	pass



func change_state( new_state : KillerState ) -> void:
	
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.enter()
