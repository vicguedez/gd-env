extends Node

## Emitted when loaded envs are cleared.
signal cleared
## Emitted when new envs have been parsed.
signal parsed

const DEFAULT_FILE_PATH = "res://.env"
const VALID_LINE_PARTS = 2

var _keys: Dictionary = {}

func _ready() -> void:
	parse(DEFAULT_FILE_PATH)

## Clears last loaded keys.
func clear() -> void:
	for key in _keys:
		OS.unset_environment(key)
	
	_keys = {}
	
	cleared.emit()

## Loads env file.
func parse(file_path: String) -> Error:
	var file := FileAccess.open(file_path, FileAccess.READ)
	
	if file == null:
		return FileAccess.get_open_error()
	
	while file.get_position() < file.get_length():
		var line = file.get_csv_line("=")
		
		# Ignore invalid lines.
		if line.size() != VALID_LINE_PARTS:
			continue
		
		var key = line[0]
		var value = line[1]
		
		_keys[key] = value
		OS.set_environment(key, value)
	
	parsed.emit()
	
	return OK

## Gets key from loaded env, returns "" if key is not found.
func get_key(key: String, default: String = "") -> String:
	return _keys.get(key, default)
