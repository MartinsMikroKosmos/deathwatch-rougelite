## Projectile.gd
## Bolter round spawned by WeaponComponent.
## Moves in a fixed direction, damages enemies on hit, deletes itself on any collision.
extends CharacterBody2D


# --- Constants ---

const LIFETIME: float = 2.0


# --- State ---

## Set by WeaponComponent before adding to the scene tree.
var direction: Vector2 = Vector2.RIGHT

## Overridden by WeaponComponent to match the weapon's damage stat.
var damage: int = 25

## Overridden by WeaponComponent to match the weapon's bullet speed.
var speed: float = 500.0


# --- Lifecycle ---

func _ready() -> void:
	get_tree().create_timer(LIFETIME).timeout.connect(queue_free)
	queue_redraw()


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(direction * speed * delta)
	if collision:
		var collider := collision.get_collider()
		if collider.has_node("HealthComponent"):
			collider.get_node("HealthComponent").take_damage(damage)
			EventBus.enemy_hit.emit(collider, damage)
		queue_free()


## Yellow circle placeholder – replace with a real bullet sprite later.
func _draw() -> void:
	draw_circle(Vector2.ZERO, 3.0, Color.YELLOW)