class_name CombatManager
extends Node

@rpc("any_peer")
func sync_damage(attacker:Player, defender:Player):
	print("Dealing damage " + attacker.name + " attacking " + defender.name)
	
	if attacker != null:
		if defender != null:
			pass
			
