## SaveSystem.gd
## Handles persistent meta-progression data across runs.
## Data is saved as JSON to the user data directory.
extends Node


# --- Constants ---

const SAVE_FILE_PATH: String = "user://save_data.json"
const SAVE_KEY_REQUISITION: String = "requisition_points"
const SAVE_KEY_TOTAL_RUNS: String = "total_runs"
const SAVE_KEY_TOTAL_KILLS: String = "total_kills"


# --- Persistent Data ---

## Currency earned across runs, used for meta-progression upgrades.
var requisition_points: int = 0

## Total number of runs attempted.
var total_runs: int = 0

## Total number of enemies killed across all runs.
var total_kills: int = 0


# --- Lifecycle ---

func _ready() -> void:
	load_data()


# --- Public API ---

## Serialises current meta-progression data and writes it to disk.
func save_data() -> void:
	var data: Dictionary = {
		SAVE_KEY_REQUISITION: requisition_points,
		SAVE_KEY_TOTAL_RUNS: total_runs,
		SAVE_KEY_TOTAL_KILLS: total_kills,
	}

	var file := FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("SaveSystem: Failed to open save file for writing. Error: %d" % FileAccess.get_open_error())
		return

	file.store_string(JSON.stringify(data))
	file.close()
	print("SaveSystem: Data saved successfully.")


## Loads meta-progression data from disk. Resets to defaults if no file exists.
func load_data() -> void:
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		print("SaveSystem: No save file found. Starting with defaults.")
		return

	var file := FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if file == null:
		push_error("SaveSystem: Failed to open save file for reading. Error: %d" % FileAccess.get_open_error())
		return

	var json_string: String = file.get_as_text()
	file.close()

	var json := JSON.new()
	var parse_error: Error = json.parse(json_string)
	if parse_error != OK:
		push_error("SaveSystem: Failed to parse save file JSON. Error: %s" % json.get_error_message())
		return

	var data: Dictionary = json.get_data()
	requisition_points = data.get(SAVE_KEY_REQUISITION, 0)
	total_runs = data.get(SAVE_KEY_TOTAL_RUNS, 0)
	total_kills = data.get(SAVE_KEY_TOTAL_KILLS, 0)
	print("SaveSystem: Data loaded. Runs: %d | Kills: %d | RP: %d" % [total_runs, total_kills, requisition_points])


## Adds requisition points and immediately persists the change.
## [param amount] The number of points to add. Must be non-negative.
func add_requisition_points(amount: int) -> void:
	if amount < 0:
		push_warning("SaveSystem: add_requisition_points() received negative value: %d" % amount)
		return
	requisition_points += amount
	save_data()
