class_name ExposedStatus
extends Status

var MODIFIER := 0.5


func apply_status(target: Node) -> void:
	print ("%s should take %s%% more damage!" % [target, MODIFIER * 100])
	
	var damage_effect := DamgeEffect.new()
	damage_effect.amount = 12
	damage_effect.execute([target])
	
	
	status_applied.emit(self)

