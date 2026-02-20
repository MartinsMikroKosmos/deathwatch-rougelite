## Marine.gd
## Player-controlled Deathwatch Space Marine.
## Handles WASD movement and mouse aiming via _physics_process.
class_name Marine
extends CharacterBody2D


# --- Constants ---

const SPEED_DEFAULT: float = 150.0
const MUZZLE_OFFSET: float = 30.0

const PROJECTILE_SCENE: PackedScene = preload("res://src/actors/marine/Projectile.tscn")


# --- Exports ---

@export var speed: float = SPEED_DEFAULT


# --- Node References ---

@onready var health_component: HealthComponent = $HealthComponent


# --- Lifecycle ---

func _ready() -> void:
	health_component.died.connect(_on_died)


func _physics_process(_delta: float) -> void:
	_handle_movement()
	_handle_aiming()


# --- Private ---

## Reads WASD / arrow key input and moves the marine using move_and_slide.
func _handle_movement() -> void:
	var direction: Vector2 = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down"
	)
	velocity = direction * speed
	move_and_slide()


## Rotates the entire Marine node to face the current mouse position.
func _handle_aiming() -> void:
	var direction: Vector2 = get_global_mouse_position() - global_position
	rotation = direction.angle()


## Spawns a projectile on left-click.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		_shoot()


## Instances a Projectile and launches it in the current facing direction.
func _shoot() -> void:
	var projectile: CharacterBody2D = PROJECTILE_SCENE.instantiate()
	var shoot_direction: Vector2 = Vector2.from_angle(rotation)
	get_tree().current_scene.add_child(projectile)
	# Set global_position after add_child so the transform is valid
	projectile.global_position = global_position + shoot_direction * MUZZLE_OFFSET
	projectile.direction = shoot_direction


# --- Signal Handlers ---

func _on_died() -> void:
	EventBus.marine_died.emit()
	print("Marine has fallen.")
	# Disable physics and input while death is handled
	set_physics_process(false)