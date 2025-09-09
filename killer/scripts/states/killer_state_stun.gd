class_name KillerStateStun extends KillerState


@export var anim_name : String = "stun"
@export var knockback_speed : float = 200.0
@export var decelerate_spped : float = 10.0

@export_category("AI")
@export var next_state : KillerState

var _damaged_position : Vector2
var _direction : Vector2
var _animation_finished : bool = false

## What happens when we initialize  this State?
func init() -> void: 
	#killer.killer_damaged.connect( _on_killer_damaged )
	pass


## What happens when the killer enters this State?
func enter() -> void: 
	killer.invulnerable = true
	_animation_finished = false
	
	_direction = killer.global_position.direction_to( _damaged_position )
	
	#_direction = killer.DIR_4[ rand ]
	killer.set_direction( _direction )
	killer.velocity = _direction * -knockback_speed
	
	killer.update_animation( anim_name )
	killer.animation_player.animation_finished.connect( _on_animation_finished )
	pass


## What happens when the killer exits this State?
func exit() -> void:
	killer.invulnerable = false
	killer.animation_player.animation_finished.disconnect( _on_animation_finished )
	pass


## What happens during the _physics_process update in this State?
func process( _delta : float ) -> KillerState:
	if _animation_finished == true:
		return next_state
	killer.velocity -= killer.velocity * decelerate_spped * _delta
	return null


## What happens during the _physics_process update in this State?
func physics( _delta : float ) -> KillerState:
	return null


func _on_killer_damaged( hurt_box : HurtBox ) -> void:
	_damaged_position = hurt_box.global_position
	state_machine.change_state( self )
	


func _on_animation_finished( _a : String ) -> void:
	_animation_finished = true
