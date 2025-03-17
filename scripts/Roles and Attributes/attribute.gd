class_name Attribute

var name : String
var defaultValue : float
var currentValue : float

func _init (n:String, def:float):
	name = n
	defaultValue = def 
	currentValue = defaultValue
	
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
