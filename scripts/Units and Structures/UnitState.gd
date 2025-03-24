class_name UnitState
extends Node

var state_name : String = "Default State"

var unit : Unit
var animation : Animation

func _init(u:Unit) -> void:
	unit = u
	
func OnEnter() -> void:
	print (state_name + "State Entered")
	pass  
	
func Run() -> void:
	pass
	
func OnExit() -> void:
	print (state_name + " State Exited")
	pass
