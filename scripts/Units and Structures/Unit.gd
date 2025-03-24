class_name Unit
extends Node

enum UnitType {None, Character, Generic, Structure}
var Type : UnitType = UnitType.None

var current_state : UnitState

func _init() -> void:
	pass
	
func give_move_command (pos:Vector3):
	print("sending move command")
	change_state(State_MovingToLocation.new(self, pos))
	
func give_attack_command(u:Unit):
	if u != null:
		print ("sending attack command")
		change_state(State_MovingToTarget.new(self, u))
		
func set_animation(a:Animation):
	if a != null:
		print ("setting animation")
	
func _ready() -> void:
	change_state(State_Idle.new(self))
	pass

func change_state(new_state: UnitState) -> void:
	if current_state:
		current_state.OnExit()
	current_state = new_state
	current_state.OnEnter()

func _process(delta: float) -> void:
	if current_state:
		current_state.Run()
