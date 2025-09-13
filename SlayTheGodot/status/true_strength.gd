class_name TrueStrength
extends Status

const MUSCLE_STATUS := preload("res://status/muscle.tres")


var stacks_per_turn := 2

func apply_status(target: Node) -> void:
	print  ("My status targets %s" % target)
	
	var status_effect := StatusEffect.new()
	var muscle := MUSCLE_STATUS.duplicate()
	muscle.stacks = stacks_per_turn
	status_effect.status = muscle
	status_effect.execute([target])


	status_applied.emit(self)

