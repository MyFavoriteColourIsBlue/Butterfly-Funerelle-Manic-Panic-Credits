class_name KillerStateWander extends KillerState


@export var anim_name : String = "idle"
@export var wander_speed : float = 20.0

@export_category("AI")
@export var state_animation_duration : float = 0.5
@export var state_cycles_min : int = 1
@export var state_cycles_max : int = 3
@export var next_state : KillerState

var _timer : float = 0.0
var _direction : Vector2

## What happens when we initialize  this State?
func init() -> void: 
	pass


## What happens when the killer enters this State?
func enter() -> void: 
	_timer = randi_range( state_cycles_min, state_cycles_max ) * state_animation_duration
	var rand = randi_range( 0, 3 )
	_direction = killer.DIR_4[ rand ]
	killer.velocity = _direction * wander_speed
	killer.set_direction( _direction )
	killer.update_animation( anim_name )
	pass


## What happens when the killer exits this State?
func exit() -> void:
	pass


## What happens during the _physics_process update in this State?
func process( _delta : float ) -> KillerState:
	_timer -= _delta
	if _timer < 0:
		return next_state
	return null


## What happens during the _physics_process update in this State?
func physics( _delta : float ) -> KillerState:
	return null
