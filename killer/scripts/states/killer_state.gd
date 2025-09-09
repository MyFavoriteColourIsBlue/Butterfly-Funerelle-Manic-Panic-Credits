class_name KillerState extends Node


## Sotes a reference to the killer that this state belong to 
var killer : Killer
var state_machine : KillerStateMachine


## What happens when we initialize  this State?
func init() -> void: 
	pass

## What happens when the killer enters this State?
func enter() -> void: 
	pass


## What happens when the killer exits this State?
func exit() -> void:
	pass


## What happens during the _physics_process update in this State?
func process( _delta : float ) -> KillerState:
	return null


## What happens during the _physics_process update in this State?
func physics( _delta : float ) -> KillerState:
	return null
