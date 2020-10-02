extends Timer

onready var parent = get_parent()

var is_active : bool = true


func _init() -> void:
    one_shot = true
    autostart = true


func _ready() -> void:
    if not is_active:
        return
    
    yield(get_parent(), "ready")
    connect("timeout", parent, "queue_free")


func _set_is_active(value: bool) -> void:
    is_active = value
    stop()