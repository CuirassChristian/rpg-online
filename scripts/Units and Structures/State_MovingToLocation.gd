extends UnitState
class_name State_MovingToLocation

func _init(u:Unit, pos:Vector3) -> void:
	state_name = "MovingTo"
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
