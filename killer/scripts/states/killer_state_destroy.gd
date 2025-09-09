class_name KillerStateDestroy extends KillerState


@export var anim_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_spped : float = 10.0

@export_category("AI")

var _damage_position : Vector2
var _direction : Vector2


## What happens when we initialize  this State?
func init() -> void: 
	#killer.killer_destroyed.connect( _on_killer_destroyed )
	pass


## What happens when the killer enters this State?
func enter() -> void: 
	killer.invulnerable = true
	_direction = killer.global_position.direction_to( _damage_position )
	killer.set_direction( _direction )
	killer.velocity = _direction * -knockback_speed
	killer.update_animation( anim_name )
	killer.animation_player.animation_finished.connect( _on_animation_finished )
	disable_hurt_box()
	pass


## What happens when the killer exits this State?
func exit() -> void:
	pass


## What happens during the _physics_process update in this State?
func process( _delta : float ) -> KillerState:
	killer.velocity -= killer.velocity * decelerate_spped * _delta
	return null


## What happens during the _physics_process update in this State?
func physics( _delta : float ) -> KillerState:
	return null


func _on_killer_destroyed( hurt_box : HurtBox ) -> void:
	_damage_position = hurt_box.global_position
	state_machine.change_state( self )
	

func _on_animation_finished( _a : String ) -> void:
	killer.que_free()



func disable_hurt_box() -> void:
	var hurt_box : HurtBox = killer.get_node_or_null("HurtBox")
	if hurt_box:
		hurt_box.monitoring = false
