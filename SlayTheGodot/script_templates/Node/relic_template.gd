
extends Relic

var member_var := 0

func initialize_relic(_owner: RelicUI) -> void:
	print ("Initialized relic: %s" % relic_name)
	
	
func activate_relic(_owner: RelicUI) -> void:
	print("Activated relic: %s" % relic_name)
	
	
func deactivate_relic(_owner: RelicUI) -> void:
	print("Deactivated relic: %s" % relic_name)
	
	

func get_tooltip() -> String:
	return tooltip