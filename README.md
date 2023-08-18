# gd-env

Godot 4 addon for loading .env files.

> :warning: `.env` files should never be commited to source control, remember to add them to a `.gitignore` file.

## Installing

1. Copy `addons` to the root of your project.
2. Activate the plugin by going to `Project -> Settings -> Plugins`, click enable for `GD Env`.

## Using

By default the plugin will auto load the env file at `res://.env` at project launch.

GDScript `FileAccess.get_csv_line` is used to read the lines, read the docs on it to avoid possible parsing errors.

### Loading custom .env

```gdscript
extends Node

func _ready() -> void:
	# Optional, use only if current env should not be accesible anymore.
	Env.clear()
	
	var parse_result: Error = Env.parse("res://.env")
	
	if parse_result != OK:
		return

	# Assume MY_KEY has been parsed, its value can be accessed either way:
	# Env.get_key("MY_KEY")
	# OS.get_environment("MY_KEY)
```

## Signals
```gdscript
## Emitted when loaded envs are cleared.
signal cleared

## Emitted when new envs have been parsed.
signal parsed
```

## Methods

```gdscript
## Clears last loaded keys.
func clear() -> void

## Loads env file.
func parse(file_path: String) -> Error

## Gets key from loaded env, returns "" if key is not found.
func get_key(key: String, default: String = "") -> String
```