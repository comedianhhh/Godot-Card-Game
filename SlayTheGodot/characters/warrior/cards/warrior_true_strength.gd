extends Card
const TRUE_STRENGTH_FROM_STATUS := preload("res://status/true_strength.tres")


func apply_effects(targets: Array[Node]) -> void:
	var status_effect := StatusEffect.new()
	var true_strength := TRUE_STRENGTH_FROM_STATUS.duplicate()
	status_effect.status = true_strength
	status_effect.execute(targets)
