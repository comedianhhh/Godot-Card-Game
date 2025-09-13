class_name ModifierValue
extends Node

enum Type {PERCENT_BASED, FLAT}
	
@export var type: Type
@export var percent_value: float
@export var flat_value: int
@export var source: String


static func create_new_modifier(modifier_source: String, what_type: Type) -> ModifierValue:
	var modifier := ModifierValue.new()
	modifier.source = modifier_source
	modifier.type = what_type
	return modifier
	
	
