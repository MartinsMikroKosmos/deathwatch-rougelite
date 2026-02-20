## WeaponComponent.gd
## Handles weapon firing logic: spawning bullets, fire rate cooldown, and muzzle offset.
## Attach as a child Node to any actor that can shoot.
extends Node


# --- Exports ---

## The bullet scene to instantiate on each shot.
@export var bullet_scene: PackedScene

## Minimum seconds between shots.
@export var fire_rate: float = 0.2

## How far from the actor's origin the bullet spawns (pixels, in facing direction).
@export var muzzle_offset: float = 30.0

## Damage passed to each spawned bullet.
@export var damage: int = 25

## Speed passed to each spawned bullet.
@export var bullet_speed: float = 500.0


# --- State ---

var _can_shoot: bool = true


# --- Public API ---

## Fires a bullet from [param origin] toward [param direction].
## Does nothing if still on cooldown or no bullet_scene is assigned.
func shoot(origin: Vector2, direction: Vector2) -> void:
	if not _can_shoot:
		return
	if bullet_scene == null:
		push_warning("WeaponComponent: bullet_scene is not set.")
		return

	_can_shoot = false
	_spawn_bullet(origin, direction)
	get_tree().create_timer(fire_rate).timeout.connect(_on_cooldown_expired)


## Returns true when the weapon is ready to fire.
func can_shoot() -> bool:
	return _can_shoot


# --- Private ---

func _spawn_bullet(origin: Vector2, direction: Vector2) -> void:
	var bullet: CharacterBody2D = bullet_scene.instantiate()
	bullet.direction = direction
	bullet.damage = damage
	bullet.speed = bullet_speed
	get_tree().current_scene.add_child(bullet)
	# Set global_position after add_child so the transform is valid in the scene tree
	bullet.global_position = origin + direction * muzzle_offset


func _on_cooldown_expired() -> void:
	_can_shoot = true
