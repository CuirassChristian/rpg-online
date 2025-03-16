class_name Weapon

@export var name: String = "DefaultWeapon"
enum WeaponType {Melee, Gun}

# Ammo - Reload
@export var maxTotalAmmo: int = 100
@export var maxMagazineSize: int = 20
@export var reloadTime: float = 3

# animation
@export var weaponSwitchDelay: float = 0.5

# Stats
@export var weaponType: WeaponType = WeaponType.Melee
@export var baseDamage: float = 5
@export var maxRange: float = 80
@export var falloffRange: float = 40
@export var damageFallOffFactor: float = 0.25

func _init (name:String, type: WeaponType, dmg: float):
	self.name = name
	self.weaponType = type
	self.baseDamage = dmg
	
