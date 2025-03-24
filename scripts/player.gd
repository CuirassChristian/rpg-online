class_name Player
extends CharacterBody3D

var ref_local_player : Player

var SPEED = 7
const JUMP_VELOCITY = 6

# Mouse Settings
const lookSpeedAccel = 12

# Move variables
var lookVec = Vector2(0,0)
var mouse_movement = Vector2()

@onready var camera = $Camera3D
# current role
var role : Role
var roleType : Role.RoleType
var ref_role_manager : RoleManager
var ref_game_coordinator
var current_role_text : Label

#attributes
@onready var character_attributes = Array([])
var ref_attribute_manager 
var attribute_text : Label

var player_active : bool

var currentHealth : float
var currentEnergy : float
var currentStamina : float

func _enter_tree():
	var id = str(name).to_int()
	set_multiplayer_authority(id)
	
func _ready():
	ref_local_player = self
	if not is_multiplayer_authority():
		return
	
	player_active = false
	current_role_text = $"Parent Canvas/Gameplay Canvas/Panel/current_role_label"
	attribute_text = $"Parent Canvas/CanvasLayer/PanelContainer/Panel/ui_attribute_text"
	var world_node = get_tree().get_root().get_node("World")
	var attributes = world_node.get_node("Manager Object/Attributes")
	ref_attribute_manager = attributes
	ref_game_coordinator = world_node.get_node("Manager Object/Game Coordinator")
	ref_role_manager = world_node.get_node("Manager Object/Role Manager")
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	ref_role_manager.local_player = ref_local_player
	
	camera.current = true
	
func set_role(r:Role):
	role = r
	roleType = r.roleType
	#current_role_text.text = "Role: " + r.name
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	_initialize_character()
	
func _initialize_character():
	var count = 0

	var attributes = ref_attribute_manager.get_attributes_for_role(role.roleType)

	for attribute in attributes:
		character_attributes.insert(count, Attribute.new(attribute.name, attribute.defaultValue))
		count += 1
		print("Adding " + attribute.name + " to character." + str(attribute.defaultValue))
		
	var ms_stat : Attribute
	var agi_stat : Attribute
	# stat setup
	for Attribute in character_attributes:
		if Attribute.name == "MoveSpeed":
			ms_stat = Attribute
		if Attribute.name == "Agility":
			agi_stat = Attribute
			
	
	SPEED = StatCalc.get_move_speed(ms_stat.defaultValue, agi_stat.currentValue)
	ms_stat.currentValue = SPEED
	player_active = true
	_update_ui_details()

	
		
func _update_ui_details():
	if not is_multiplayer_authority():
		return
		
	ref_attribute_manager.attributes_text_label.text = ""
	print("Updating UI for player: ")

	for attribute in character_attributes:
		var str_value = str(attribute.currentValue)
		var str_name = str(attribute.name)
		ref_attribute_manager.attributes_text_label.text += str_name + "  " + str_value + "\n"
		
	
func _process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
		
	if player_active == false:
		return
		
	_updateUI()
	# get input events from mouse 
	
func _updateUI():
	pass
	
func _input(event: InputEvent) -> void:
	if not is_multiplayer_authority():
		return
		
	if player_active == false:
		return
		
	if event is InputEventMouseMotion:
		mouse_movement.x = -event.relative.x
		mouse_movement.y = -event.relative.y

func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
		
	if player_active == false:
		return
		
	# Reset look
	lookVec.x = 0
	lookVec.y = 0
	lookVec.x += (mouse_movement.x * lookSpeedAccel) * delta
	lookVec.y += (mouse_movement.y * lookSpeedAccel) * delta
	
	mouse_movement = Vector2()

	# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity() * 2) * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Handling of look
	rotate_y(lookVec.x * delta)
	camera.rotate_x(lookVec.y * delta)
	camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)

	var direction
	
	var moveHorizontal = Input.get_axis("MoveRight", "MoveLeft")
	var moveVertical = Input.get_axis("MoveDown", "MoveUp")
	
	if is_on_floor(): 
		direction = (transform.basis * Vector3(-moveHorizontal, 0, -moveVertical)).normalized()
	else:

		var air_control_factor = 0.1 
		var momentum_factor = 0.3
		direction = (transform.basis * Vector3(-moveHorizontal, 0, -moveVertical)).normalized() * air_control_factor
		
		var momentum = Vector2(velocity.x, velocity.z).normalized() * (1 - momentum_factor)
		direction += Vector3(momentum.x, 0, momentum.y)

		
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func health_changed():
	pass
