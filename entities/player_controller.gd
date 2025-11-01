class_name PlayerController
extends Node

## Controls the player character.

@onready var player: CharacterBody2D = $".."
@onready var anim_player: AnimationPlayer = $"../AnimationPlayer"
@onready var player_name_label: Label = $"../PanelContainer/MarginContainer/VBoxContainer/PlayerNameLabel"
@onready var peer_id_label: Label = $"../PanelContainer/MarginContainer/VBoxContainer/PeerIdLabel"
@onready var player_sprite: Sprite2D = $"../PlayerSprite"
@onready var chat_ui: ChatUI = $"../Camera2D/ChatUi"
@onready var camera_2d: Camera2D = $"../Camera2D"


## Speed of the player in pixels per second
@export var speed: float = 200.0
var can_move: bool = true


func _ready() -> void:
	if not is_multiplayer_authority():
		camera_2d.queue_free()
		return

	if chat_ui != null:
		chat_ui.start_chat.connect(func() -> void: can_move = false)
		chat_ui.stop_chat.connect(func() -> void: can_move = true)


func _physics_process(_delta: float) -> void:
	if not is_multiplayer_authority(): return

	if not can_move: return
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", 
		"move_down").normalized()
	
	if direction.x > 0:
		player_sprite.flip_h = true
	if direction.x < 0:
		player_sprite.flip_h = false
	
	player.velocity = direction * speed
	player.move_and_slide()
	
	if player.velocity.length() > 0.1:
		anim_player.play("walking")
	else:
		anim_player.play("idle")
