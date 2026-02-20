## WeaponComponent.gd
## Handles weapon firing logic: ammo, fire rate, reload, and bullet spawning.
## Attach as a child Node to any actor that can shoot.
## Requires a MuzzlePoint (Node2D) child node positioned at the gun barrel.
extends Node


# --- Exports ---

## The bullet scene to instantiate on each shot.
@export var bullet_scene: PackedScene

## Stats resource for the bullet (damage, speed, range, piercing).
@export var bullet_data: BulletData

## Maximum rounds before a reload is required.
@export var magazine_size: int = 30

## Time in seconds to reload.
@export var reload_time: float = 2.0

## Minimum seconds between individual shots.
@export var fire_rate: float = 0.15


# --- Node References ---

@onready var muzzle_point: Node2D = $MuzzlePoint


# --- State ---

var _current_ammo: int
var _can_shoot: bool = true
var _is_reloading: bool = false


# --- Lifecycle ---

func _ready() -> void:
	_current_ammo = magazine_size


# --- Public API ---

## Fires one bullet toward [param world_position] (typically the mouse cursor).
## Does nothing if on cooldown, reloading, or out of ammo.
func shoot(world_position: Vector2) -> void:
	if not _can_shoot or _is_reloading or _current_ammo <= 0:
		return
	if bullet_scene == null or bullet_data == null:
		push_warning("WeaponComponent: bullet_scene or bullet_data is not assigned.")
		return

	_can_shoot = false
	var direction: Vector2 = (world_position - muzzle_point.global_position).normalized()
	_spawn_bullet(direction)

	_current_ammo -= 1
	EventBus.ammo_changed.emit(_current_ammo, magazine_size)

	await get_tree().create_timer(fire_rate).timeout
	_can_shoot = true


## Starts a reload. Ignored if already reloading or magazine is full.
func reload() -> void:
	if _is_reloading or _current_ammo == magazine_size:
		return
	_is_reloading = true
	EventBus.reload_started.emit(reload_time)

	await get_tree().create_timer(reload_time).timeout

	_current_ammo = magazine_size
	_is_reloading = false
	EventBus.ammo_changed.emit(_current_ammo, magazine_size)


## Returns the current ammo count.
func get_current_ammo() -> int:
	return _current_ammo


# --- Private ---

func _spawn_bullet(direction: Vector2) -> void:
	var bullet: Area2D = bullet_scene.instantiate()
	bullet.setup(direction, bullet_data, get_parent())
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = muzzle_point.global_position