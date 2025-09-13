class_name StatusTemplate
extends Status

var member_var := 0

func initialize_status(_target: Node) -> void:
	print ("Initialized status on %s" % _target.name)
	
	

func apply_status(target: Node) -> void:
	print  ("My status targets %s" % target)
	print ("It does %s something!" % member_var)
	
	status_applied.emit(self)
