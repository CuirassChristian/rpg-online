extends CharacterBody3D

const SPEED = 7
const JUMP_VELOCITY = 6

# Mouse Settings
const lookSpeedAccel = 12

# Move variables
var lookVec = Vector2(0,0)
var mouse_movement = Vector2()

@onready var camera = $Camera3D

func _enter_tree():
	var id = str(name).to_int()
	set_multiplayer_authority(id)
	
	
func _ready():
	if not is_multiplayer_authority():
		return
		
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera.current = true

	
func _process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
		
	_updateUI()
	# get input events from mouse 
	
func _updateUI():
	pass
	
func _input(event: InputEvent) -> void:
		
	if event is InputEventMouseMotion:
		mouse_movement.x = -event.relative.x
		mouse_movement.y = -event.relative.y

func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
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
