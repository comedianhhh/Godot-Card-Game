class_name ExposedStatus
extends Status

var MODIFIER := 0.5

func get_tooltip() -> String:
	return tooltip % duration

func initialize_status(target: Node) -> void:
	assert(target.get("modifier_handler"), "No modifiers on %s" % target)
	
	var dmg_taken_modifer: Modifier = target.modifier_handler.get_modifier(Modifier.Type.DMG_TAKEN)
	assert(dmg_taken_modifer, "No DMG_TAKEN modifier on %s" % target)
	
	var exposed_modifier_value :=dmg_taken_modifer.get_value("exposed")
	
	if not exposed_modifier_value:
		exposed_modifier_value = ModifierValue.create_new_modifier("exposed", ModifierValue.Type.PERCENT_BASED)
		exposed_modifier_value.percent_value = MODIFIER
		dmg_taken_modifer.add_new_value(exposed_modifier_value)
		
	if not status_changed.is_connected(_on_status_changed):
		status_changed.connect(_on_status_changed.bind(dmg_taken_modifer))
	
	
	
	
	
	
func _on_status_changed(dmg_taken_modifer: Modifier) -> void:	
	if duration <= 0 and dmg_taken_modifer:
		dmg_taken_modifer.remove_value("exposed")
