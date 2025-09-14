extends Card

const EXPOSED_STATUS := preload("res://status/exposed.tres")

var base_damage := 4
var exposed_duration := 2

func get_default_tooltip() -> String:
	return tooltip_text % base_damage


func get_updated_tooltip(_player_modifiers: ModifierHandler, _enemy_modifiers: ModifierHandler) -> String:
	var modified_damage := _player_modifiers.get_modified_value(base_damage, Modifier.Type.DMG_DEALT)

	if _enemy_modifiers:
		modified_damage = _enemy_modifiers.get_modified_value(modified_damage, Modifier.Type.DMG_TAKEN)

	return tooltip_text % modified_damage


func apply_effects(targets: Array[Node], modifiers: ModifierHandler) -> void:
	var damage_effect := DamgeEffect.new()
	damage_effect.amount = modifiers.get_modified_value(base_damage, Modifier.Type.DMG_DEALT)
	damage_effect.sound = sound
	damage_effect.execute(targets)
	
	
	var status_effect := StatusEffect.new()
	var exposed := EXPOSED_STATUS.duplicate()
	exposed.duration = exposed_duration
	status_effect.status = exposed
	status_effect.execute(targets)
	
