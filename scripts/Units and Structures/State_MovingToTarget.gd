extends UnitState
class_name State_MovingToTarget

func _init(u:Unit, a:Unit) -> void:
	state_name = "MovingToTarget"
	print ("Moving to target " + a.name)
	super._init(u)
	
func OnEnter() -> void:
	super.OnEnter()
	if unit != null:
		unit.set_animation(animation)
	
func Run() -> void:
	super.Run()
	pass
	
func OnExit() -> void:
	super.OnExit()
	pass
