extends CanvasLayer

const maximumHealthDefault = 150
const maximumEnergyDefault = 80
const maximumStaminaDefault = 120

var currentHealth = 0
var currentEnergy = 0
var currentStamina = 0

#ui
@onready var health_bar = $"PanelContainer/VBoxContainer/Health Bar"
@onready var energy_bar = $"PanelContainer/VBoxContainer/Energy Bar"
@onready var stamina_bar = $"PanelContainer/VBoxContainer/Stamina Bar"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _initVitals():

	# Initialize health bar
	if health_bar == null:
		print("Health bar not located")
		return
		
	if energy_bar == null:
		print ("Energy bar not located")
		return
		
	if stamina_bar == null:
		print ("Stamina bar not located")
		return
		
	health_bar.max_value = maximumHealthDefault
	health_bar.min_value = 0
	currentHealth = 150
	health_bar.value = currentHealth  # Set the current value for the health bar
	
	# Initialize energy bar
	energy_bar.max_value = maximumEnergyDefault
	energy_bar.min_value = 0
	currentEnergy = 80
	energy_bar.value = currentEnergy  # Set the current value for the energy bar
	
	# Initialize stamina bar
	stamina_bar.max_value = maximumStaminaDefault
	stamina_bar.min_value = 0
	currentStamina = 90
	stamina_bar.value = currentStamina  # Set the current value for the stamina bar
