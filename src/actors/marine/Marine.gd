## Marine.gd
## Player-controlled Deathwatch Space Marine.
## Handles WASD movement and mouse aiming via _physics_process.
class_name Marine
extends CharacterBody2D


# --- Constants ---

const SPEED_DEFAULT: float = 150.0


# --- Exports ---

@export var speed: float = SPEED_DEFAULT


# --- Node References ---

@onready var health_component: HealthComponent = $HealthComponent
@onready var sprite: Sprite2D = $Sprite2D


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


## Rotates the Sprite2D to face the current mouse position.
func _handle_aiming() -> void:
	sprite.look_at(get_global_mouse_position())


# --- Signal Handlers ---

func _on_died() -> void:
	EventBus.marine_died.emit()
	print("Marine has fallen.")
	# Disable physics and input while death is handled
	set_physics_process(false)