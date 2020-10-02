#* This is a base class for area with damege over time effects

extends Area2D
class_name AreaDamage

export(int) var damage := 1
export(float) var rate_of_ticks := 1.0
# TODO add options for shapes ???

var is_active : bool = true setget _set_is_active
var is_damaging : bool = false
var targets : Array = []

onready var timer : Timer = $Timer


func _init() -> void:
    connect("area_entered", self, "_add_target")
    connect("area_exited", self, "_remove_target")


func _ready() -> void:
    timer.connect("timeout", self, "_do_damage")
    timer.wait_time = 1 / rate_of_ticks
    timer.one_shot = false
    start_damage_over_time()

    
func start_damage_over_time() -> void:
    timer.start()


func stop_damage_over_time() -> void:
    timer.stop()


func _do_damage() -> void:
    if is_active and targets.size() > 0:
        for target in targets:
            target.get_damage(damage)


func _set_is_active(value: bool) -> void:
    is_active = value
    is_damaging = value
    visible = value
    monitoring = value
    timer.stop()


func _add_target(area: Area2D) -> void:
    if area is DamageDetector:
        targets.append(area)


func _remove_target(area: Area2D) -> void:
    if area is DamageDetector:
        var target_index := targets.find(area)
        targets.remove(target_index)