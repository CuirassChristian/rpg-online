extends Node3D

@onready var mainMenu = $"Main Canvas"
@onready var addressEntry = $"Main Canvas/Title Menu/MarginContainer/VBoxContainer/Address Edit"
@onready var interface = $"Player Canvas"
@onready var random = $"Player Canvas/PanelContainer/VBoxContainer/Energy Bar"
@onready var in_game_menu = $InGameMenu
const stupid_thing = preload("res://prefabs/whitebox/stupid_thing.tscn")
const Player = preload("res://prefabs/player_default.tscn")
const PORT = 13370
var enet_peer = ENetMultiplayerPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interface.hide()
	in_game_menu.hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	
func _on_host_button_pressed() -> void:
	mainMenu.hide()
	interface.show()
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(_on_player_quit)
	add_player(multiplayer.get_unique_id())

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Dog"):
		if in_game_menu.visible:
			in_game_menu.hide() 
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:	
			in_game_menu.show()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
		

func _on_join_button_pressed() -> void:
	mainMenu.hide()
	interface.show()
	enet_peer.create_client("localHost", PORT)
	multiplayer.multiplayer_peer = enet_peer
	
func _make_stupid_thing ():
	var random = randi_range(5, 20)
	var newThing = stupid_thing.instantiate()
	var pos = Vector3(0, random, 0)
	print(random)
	add_child(newThing)
	newThing.translate(pos)
	print(newThing.get_parent().name)
	
# Generic Add Player Routine
func add_player (peer_id):
	var player = Player.instantiate()
	player.name = str(peer_id)
	add_child(player)
	var random = randi_range(5, 20)
	var pos = Vector3(0, random, 0)
	print(random)
	_make_stupid_thing()
	
func update_vitals(hp, ep, sp):
	interface.health_bar.value = hp
	interface.energy_bar.value = hp
	interface.stamina_bar.value = hp

func deal_damage(damage):
	if multiplayer.is_server():
		print("Dealing damage")

func _on_multiplayer_spawner_spawned(node: Node) -> void:
	# if node.is_multiplayer_authority():
		# node.health_changed.connect(update_vitals(150, 80, 80))
	pass

func _on_player_quit(peer_id):
	pass

func _on_quit_button_pressed() -> void:
	multiplayer.multiplayer_peer = null


func _on_area_3d_area_entered(area: Area3D) -> void:
	print("Area was entered")
