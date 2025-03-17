extends Node
var ref_role_manager
var ref_attribute_manager
var ref_local_player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ref_role_manager = $"../Role Manager"
	ref_attribute_manager = $"../Attributes"
	
func set_local_player(p:Player):
	ref_local_player = p

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
