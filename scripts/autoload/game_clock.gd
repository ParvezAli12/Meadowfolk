extends Node

signal day_changed(day: int)

const DAY_LENGTH_SECONDS := 600.0  # real seconds for one full game day
const START_HOUR := 6.0

var day := 1
var time_of_day := START_HOUR / 24.0  # 0.0 = midnight, 0.5 = noon

func _process(delta: float) -> void:
	var multiplier := 20.0 if Input.is_action_pressed("debug_fast_forward") else 1.0
	time_of_day += delta * multiplier / DAY_LENGTH_SECONDS
	if time_of_day >= 1.0:
		time_of_day -= 1.0
		day += 1
		day_changed.emit(day)

func get_time_string() -> String:
	var total_minutes := int(time_of_day * 24.0 * 60.0)
	var hours := floori(total_minutes / 60.0)
	var minutes := total_minutes % 60
	return "%02d:%02d" % [hours, minutes]
