## Projectile.gd
## Bolter round fired by the Marine.
## Moves in a fixed direction, damages enemies on hit, deletes itself on any collision.
extends CharacterBody2D


# --- Constants ---

const SPEED: float = 500.0
const LIFETIME: float = 2.0
const DAMAGE: int = 25


# --- State ---

## Set by Marine._shoot() before adding to the scene tree.
var direction: Vector2 = Vector2.RIGHT


# --- Lifecycle ---

func _ready() -> void:
	# Auto-delete if the projectile never hits anything
	get_tree().create_timer(LIFETIME).timeout.connect(queue_free)
	queue_redraw()


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(direction * SPEED * delta)
	if collision:
		var collider := collision.get_collider()
		if collider.has_node("HealthComponent"):
			collider.get_node("HealthComponent").take_damage(DAMAGE)
		queue_free()


## Yellow circle placeholder – remove once a real bullet sprite is added.
func _draw() -> void:
	draw_circle(Vector2.ZERO, 3.0, Color.YELLOW)
