extends Node2D

const START_LEVEL : String = "res://levels/(0)Prologue/(0)_prologue.tscn"

@export var music : AudioStream
@export var button_focus_audio : AudioStream
@export var button_press_audio : AudioStream

@onready var button_new: Button = $CanvasLayer/Control/ButtonNew
@onready var button_continue: Button = $CanvasLayer/Control/ButtonContinue
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer




func _ready() -> void:
	get_tree().paused = true
	PlayerManager.player.visible = false
	PlayerHud.visible = false
	PauseMenu.process_mode = Node.PROCESS_MODE_DISABLED
	
	if SaveManager.get_save_file() == null:
		button_continue.disabled = true
		button_continue.visible = false
	
	setup_title_screen()
	
	LevelManager.level_load_started.connect( exit_title_screen )
	
	pass



func setup_title_screen() -> void:
	button_new.pressed.connect( start_game )
	button_continue.pressed.connect( load_game )
	button_new.grab_focus()
	
	button_new.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	button_continue.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	
	button_new.pressed.connect( play_audio.bind( button_press_audio ) )
	button_continue.pressed.connect( play_audio.bind( button_press_audio ) )
	
	AudioManager.play_music( music )
	
	pass



func start_game() -> void:
	play_audio( button_press_audio )
	LevelManager.load_new_level( START_LEVEL, "", Vector2.ZERO )
	pass



func load_game() -> void:
	play_audio( button_press_audio )
	SaveManager.load_game()
	pass



func exit_title_screen() -> void:
	PlayerManager.player.visible = true
	PlayerHud.visible = true
	PauseMenu.process_mode = Node.PROCESS_MODE_ALWAYS
	self.queue_free()
	pass


func play_audio( _a : AudioStream ) -> void:
	audio_stream_player.stream = _a
	audio_stream_player.play()
