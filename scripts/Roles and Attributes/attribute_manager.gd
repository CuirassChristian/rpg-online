extends Node

var all_attributes = Array([])
@onready var attributes_text_label : Label = $"../../Parent Canvas/CanvasLayer/PanelContainer/Panel/ui_attribute_text"
@onready var phys_dmg_label : Label = $"../../Parent Canvas/Gameplay Canvas/Panel/dmg_label"
var ref_role_manager 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ref_role_manager = $"../Role Manager"
	
	# initialize the attributes
	all_attributes.insert(0, Attribute.new("Strength", 1))
	all_attributes.insert(1, Attribute.new("Agility", 1))
	all_attributes.insert(2, Attribute.new("Intelligence", 1))
	all_attributes.insert(3, Attribute.new("Wisdom", 1))
	all_attributes.insert(4, Attribute.new("Dexterity", 1))
	all_attributes.insert(5, Attribute.new("Constitution", 1))
	all_attributes.insert(6, Attribute.new("MoveSpeed", 1))
	all_attributes.insert(7, Attribute.new("Accuracy", 1))
	
	print("Generating attributes")
	for Attribute in all_attributes:
		print(Attribute.name)
		
	print("Attributes DONE")

	
func get_attributes():
	return all_attributes
	
func get_attributes_for_role(r:Role.RoleType):
	var all_attributes_for_role = Array([])
	
	if ref_role_manager != null:
		for Role in ref_role_manager.get_roles():
			if (r == Role.roleType):

				all_attributes_for_role.insert(0, Attribute.new("Strength", Role.base_strength))
				all_attributes_for_role.insert(1, Attribute.new("Agility", Role.base_agility))
				all_attributes_for_role.insert(2, Attribute.new("Intelligence", Role.base_intelligence))
				all_attributes_for_role.insert(3, Attribute.new("Wisdom", Role.base_wisdom))
				all_attributes_for_role.insert(4, Attribute.new("Dexterity", Role.base_dexterity))
				all_attributes_for_role.insert(5, Attribute.new("Constitution", Role.base_constitution))
				all_attributes_for_role.insert(6, Attribute.new("MoveSpeed", Role.base_movespeed))
				all_attributes_for_role.insert(7, Attribute.new("Accuracy", Role.base_accuracy))
	return all_attributes_for_role
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
