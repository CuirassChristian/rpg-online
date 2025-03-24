extends Node
class_name G_StatCalc

func get_move_speed (ms:float, agi:float) -> float:
	var new_ms = ms + (agi * 0.10)
	return new_ms
