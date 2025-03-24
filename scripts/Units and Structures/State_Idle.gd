extends UnitState
class_name State_Idle

func _init(u:Unit) -> void:
	state_name = "Idle"
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
