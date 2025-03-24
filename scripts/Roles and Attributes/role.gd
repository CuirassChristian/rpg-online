class_name Role

@export var name: String = "Default Role"
# Defined Roles
enum RoleType {None, Guardian, Monk, Ranger,
 Paladin, Cleric, Wizard,
 Berserker, Druid, Rogue }

var base_strength : float
var base_agility : float
var base_intelligence : float
var base_wisdom : float
var base_dexterity : float
var base_constitution : float
var base_movespeed : float
var base_accuracy : float
	
@export var roleType: RoleType = RoleType.None
var description : String

func _init (n : String, r:RoleType, sdesc:String, st:float, agi:float, intell:float, wis:float, dex:float, con:float, ms:float, acu:float):
	name = n
	roleType = r
	description = sdesc
	base_strength = st
	base_agility = agi
	base_intelligence = intell
	base_wisdom = wis
	base_dexterity = dex
	base_constitution = con
	base_movespeed = ms
	base_accuracy = acu
	print("Initializing role: " + name)
	
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass
