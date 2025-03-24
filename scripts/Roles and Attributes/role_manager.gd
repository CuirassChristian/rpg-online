class_name RoleManager
extends Node

var all_roles = Array([])
@onready var role_button_container : VBoxContainer = $"../../Parent Canvas/Role Canvas/Role Selection Panel/VBoxContainer"
@onready var role_panel : CanvasLayer = $"../../Parent Canvas/Role Canvas"
var local_player : Player
var selected_role : Role

func _ready() -> void:
	role_panel.hide()
	
	all_roles.insert(0, Role.new("Guardian", Role.RoleType.Guardian, "high physical tank"
	, 16, 8, 4, 4, 2, 24))
	all_roles.insert(1, Role.new("Monk", Role.RoleType.Monk, "Evasion tank and support"
	, 10, 10, 6, 8, 4, 14))
	all_roles.insert(2, Role.new("Ranger", Role.RoleType.Ranger, "Ranged physical damage"
	, 4, 12, 5, 4, 16, 8))
	all_roles.insert(3, Role.new("Paladin", Role.RoleType.Paladin, "Magical tank"
	, 14, 4, 10, 10, 2, 20))
	all_roles.insert(4, Role.new("Cleric", Role.RoleType.Cleric, "Magical support"
	, 8, 3, 20, 24, 0, 10))
	all_roles.insert(5, Role.new("Wizard", Role.RoleType.Wizard, "high magical damage"
	, 2, 4, 28, 12, 0, 6))
	all_roles.insert(6, Role.new("Berserker", Role.RoleType.Berserker, "physical damage tank"
	, 28, 12, 0, 0, 2, 16))
	all_roles.insert(7, Role.new("Druid", Role.RoleType.Druid, "magical damage support"
	, 8, 8, 8, 12, 12, 10))
	all_roles.insert(8, Role.new("Rogue", Role.RoleType.Rogue, "strong physical damage"
	, 2, 25, 6, 6, 4, 10))
	
	var count : int = 0
	for Role in all_roles:
		var button = Button.new()
		button.text = Role.name
		button.add_theme_font_size_override("font_size", 10)
		button.pressed.connect(role_select_button_click.bind(count), 0)
		role_button_container.add_child(button)
		count += 1
		
		
func role_select_button_click(i:int):
	selected_role = all_roles[i]
	print ("Role selected: " + selected_role.name)
	
func get_roles():
	return all_roles

func _process(delta: float) -> void:
	pass
	
func _on_lock_in_button_pressed() -> void:
	if selected_role != null:
		print("Locking in role: " + selected_role.name)
		role_panel.hide()
		local_player.set_role(selected_role)
