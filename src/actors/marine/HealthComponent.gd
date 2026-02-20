## HealthComponent.gd
## Reusable health management component. Attach as a child Node to any actor.
## Emits local signals for the owner and also forwards changes to the global EventBus.
class_name HealthComponent
extends Node


# --- Exports ---

@export var max_health: int = 100


# --- State ---

var current_health: int


# --- Signals ---

## Emitted whenever health changes (damage or healing).
signal health_changed(current: int, maximum: int)

## Emitted when health reaches zero.
signal died


# --- Lifecycle ---

func _ready() -> void:
	current_health = max_health


# --- Public API ---

## Reduces health by [param amount]. Clamps to 0.
## Emits health_changed and died (if lethal) signals.
func take_damage(amount: int) -> void:
	if not is_alive():
		return
	current_health = clampi(current_health - amount, 0, max_health)
	health_changed.emit(current_health, max_health)
	EventBus.health_changed.emit(owner, current_health, max_health)
	if current_health <= 0:
		died.emit()


## Increases health by [param amount]. Clamps to max_health.
func heal(amount: int) -> void:
	if not is_alive():
		return
	current_health = clampi(current_health + amount, 0, max_health)
	health_changed.emit(current_health, max_health)
	EventBus.health_changed.emit(owner, current_health, max_health)


## Returns true if the entity still has health remaining.
func is_alive() -> bool:
	return current_health > 0