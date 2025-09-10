class_name Campfire
extends Control

@export var char_stats: CharacterStats
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_rest_button_pressed() -> void:
	char_stats.heal(ceili(char_stats.max_health*0.3))
	animation_player.play("fade_out")
	
# This is called from AnimationPlayer at the end of the fade_out animation
func _on_fade_out_finnished() ->void:
	Events.campfire_exited.emit()
