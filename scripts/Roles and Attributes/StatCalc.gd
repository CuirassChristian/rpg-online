extends Node
class_name G_StatCalc

const dmg_per_str : float = 2.3
const dmg_per_dex : float = 0.7
const dmg_per_agi : float = 1.4
const default_spread_ : float = 25

func get_move_speed (ms:float, agi:float) -> float:
	var new_ms = ms + (agi * 0.10)
	return new_ms

func get_physical_damage_range(str: float, dex: float, agi: float, acu:float) -> damage_range:
	var out_damage_range = damage_range.new(0,0)
	var dmg_from_str = str * ( dmg_per_str)	
	var dmg_from_dex = dex * (dmg_per_dex)
	var dmg_from_agi = agi * (dmg_per_agi)
	var total_dmg = dmg_from_dex + dmg_from_str + dmg_from_agi
	var min_dmg = total_dmg / 4 + acu
	out_damage_range.min = clamp(round(min_dmg), 0, total_dmg)
	out_damage_range.max = clamp(round(total_dmg), min_dmg, 99999)
	return out_damage_range
	
