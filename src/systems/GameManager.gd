## GameManager.gd
## Global game state manager. Tracks the active run and score.
## Listens to EventBus signals to update state automatically.
class_name GameManager
extends Node


# --- Constants ---

const SCORE_PER_KILL: int = 100


# --- State ---

## Whether a run is currently in progress.
var current_run_active: bool = false

## The player's score for the current run.
var current_score: int = 0


# --- Lifecycle ---

func _ready() -> void:
	_connect_signals()


## Connects to relevant EventBus signals.
func _connect_signals() -> void:
	EventBus.run_ended.connect(_on_run_ended)
	EventBus.enemy_died.connect(_on_enemy_died)


# --- Public API ---

## Starts a new run. Resets score and marks the run as active.
func start_run() -> void:
	if current_run_active:
		push_warning("GameManager: start_run() called while a run is already active.")
		return
	current_run_active = true
	current_score = 0
	print("GameManager: Run started.")


## Ends the current run and emits the run_ended signal via EventBus.
## [param success] Pass true if the marine succeeded, false on death.
func end_run(success: bool) -> void:
	if not current_run_active:
		push_warning("GameManager: end_run() called but no run is active.")
		return
	current_run_active = false
	print("GameManager: Run ended. Success: %s | Score: %d" % [success, current_score])
	EventBus.run_ended.emit(success)


## Adds points to the current score.
## [param points] The number of points to add. Must be non-negative.
func add_score(points: int) -> void:
	if points < 0:
		push_warning("GameManager: add_score() received negative value: %d" % points)
		return
	current_score += points


# --- Signal Handlers ---

func _on_run_ended(success: bool) -> void:
	# Persist run results to SaveSystem
	SaveSystem.total_runs += 1
	SaveSystem.save_data()


func _on_enemy_died(_enemy_name: String, _position: Vector2) -> void:
	add_score(SCORE_PER_KILL)
	SaveSystem.total_kills += 1
