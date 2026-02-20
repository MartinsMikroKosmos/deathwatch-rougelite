## Bullet.gd
## Area2D-based projectile. Configured via setup() before entering the scene tree.
## Moves in _physics_process, tracks distance, deletes itself at max_range or on hit.
extends Area2D


# --- Constants ---

const LIFETIME: float = 4.0


# --- State ---

var direction: Vector2 = Vector2.RIGHT
var bullet_data: BulletData = null

## The actor that fired this bullet – excluded from hit detection.
var _shooter: Node2D = null
var _distance_traveled: float = 0.0
var _is_dead: bool = false


# --- Lifecycle ---

func _ready() -> void:
	if bullet_data == null:
		push_error("Bullet: bullet_data is null in _ready(). Was setup() called before add_child()?")
		queue_free()
		return
	body_entered.connect(_on_body_entered)
	get_tree().create_timer(LIFETIME).timeout.connect(queue_free)
	queue_redraw()


func _physics_process(delta: float) -> void:
	if _is_dead or bullet_data == null:
		return
	var step: Vector2 = direction * bullet_data.speed * delta
	position += step
	_distance_traveled += step.length()
	if _distance_traveled >= bullet_data.max_range:
		_is_dead = true
		queue_free()


## Call before add_child(). Sets direction, stats, and the shooter to ignore.
func setup(dir: Vector2, data: BulletData, shooter: Node2D = null) -> void:
	direction = dir.normalized()
	bullet_data = data
	_shooter = shooter


## Bright white circle – visible against any background during testing.
func _draw() -> void:
	draw_circle(Vector2.ZERO, 5.0, Color.WHITE)
	draw_circle(Vector2.ZERO, 3.0, Color.YELLOW)


# --- Signal Handlers ---

func _on_body_entered(body: Node2D) -> void:
	if _is_dead:
		return
	# Never hit the actor that fired this bullet
	if body == _shooter:
		return

	if body is StaticBody2D:
		_is_dead = true
		queue_free()
		return

	if body.has_node("HealthComponent"):
		body.get_node("HealthComponent").take_damage(bullet_data.damage)
		EventBus.bullet_hit.emit(body, bullet_data.damage)
		if not bullet_data.piercing:
			_is_dead = true
			queue_free()
