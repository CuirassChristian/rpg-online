extends Node

enum PickupType {Resource, Item, Armor, Weapon}
@export var this_pickup_type = PickupType.Resource
@export var regeneration_timer : float
@onready var collisionBox : Area3D = $Area3D

func _ready():
	this_pickup_type = PickupType.Weapon
	collisionBox.body_entered.connect(_on_player_entered)
	
func _init ():
	pass

func _on_player_entered ():
	give_item()
	
func give_item():
	var s : String
	s += "Granting Item: "
	match this_pickup_type:
		PickupType.Weapon:
			s += "Weapon "
		PickupType.Item:
			s += "Item "
		PickupType.Armor:
			s += "Armor "
		PickupType.Resource:
			s += "Resource "
		
	print (s)
		

func _on_area_3d_body_entered(body: Node3D) -> void:
	print ("Player entered region")
	give_item()
