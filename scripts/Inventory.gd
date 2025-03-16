extends Node

var equipped_weapon: Weapon = null

var inventory_weapons_data: Dictionary = {
	0: Weapon.new("Gauntlet", Weapon.WeaponType.Melee, 20)
}

func _ready() -> void:
	get_inventory()
		
func _process(delta: float) -> void:
	pass
		
func get_inventory():
	for Weapon in inventory_weapons_data.values():
		print("Item " + Weapon.name)
		
func add_weapon(w: Weapon):
	if inventory_weapons_data.values().has(w):
		pass
	else:
		var index = inventory_weapons_data.keys().size()
		inventory_weapons_data.get_or_add(index, w)
	
	get_inventory()
