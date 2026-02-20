## EnemyBase.gd
## Base class for all enemy actors. Handles chase AI, melee attacking, and death.
## Subclass this for enemy-specific behaviour.
class_name EnemyBase
extends CharacterBody2D


# --- Constants ---

## Melee reach in pixels – attack triggers when closer than this.
const ATTACK_RANGE: float = 32.0


# --- Exports ---

@export var enemy_data: EnemyData


# --- Node References ---

@onready var health_comp: HealthComponent = $HealthComponent


# --- State ---

var _attack_timer: float = 0.0


# --- Lifecycle ---

func _ready() -> void:
	# Override max_health with the value from the EnemyData resource
	health_comp.setup(enemy_data.max_health)
	health_comp.died.connect(_on_died)


func _physics_process(delta: float) -> void:
	_attack_timer -= delta
	_update_ai(delta)


# --- Private ---

## Core chase-and-attack AI loop. Runs every physics frame.
func _update_ai(_delta: float) -> void:
	var marine: Node2D = get_tree().get_first_node_in_group("marine")
	if marine == null:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var distance: float = global_position.distance_to(marine.global_position)

	if distance > enemy_data.detection_range:
		# Marine is out of detection range – idle
		velocity = Vector2.ZERO
		move_and_slide()
		return

	if distance > ATTACK_RANGE:
		# Chase: move toward the marine
		var direction: Vector2 = (marine.global_position - global_position).normalized()
		velocity = direction * enemy_data.move_speed
		move_and_slide()
	else:
		# In melee range – stop moving and attack on cooldown
		velocity = Vector2.ZERO
		move_and_slide()
		if _attack_timer <= 0.0:
			_attack(marine)
			_attack_timer = enemy_data.attack_cooldown


## Deals melee damage to [param target] if it has a HealthComponent.
func _attack(target: Node) -> void:
	if target.has_node("HealthComponent"):
		target.get_node("HealthComponent").take_damage(enemy_data.damage)


# --- Signal Handlers ---

func _on_died() -> void:
	EventBus.enemy_died.emit(self, enemy_data.xp_reward)
	queue_free()