extends Control

func _ready() -> void:
	printt('TEST key at "res://.env":', Env.get_key("TEST"))
