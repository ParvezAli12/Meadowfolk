extends DirectionalLight3D

@export var max_energy := 1.0
@export var day_color := Color(1.0, 0.97, 0.9)
@export var dusk_color := Color(1.0, 0.6, 0.35)

var env: Environment

func _ready() -> void:
	var world_env := get_tree().current_scene.get_node_or_null("WorldEnvironment") as WorldEnvironment
	if world_env:
		env = world_env.environment

func _process(_delta: float) -> void:
	var t := GameClock.time_of_day
	rotation_degrees.x = 90.0 - t * 360.0
	rotation_degrees.y = -30.0

	var height := sin(t * TAU - PI / 2.0)  # 1 at noon, -1 at midnight
	var daylight := clampf(height * 2.0, 0.0, 1.0)

	light_energy = max_energy * daylight
	light_color = dusk_color.lerp(day_color, daylight)
	shadow_enabled = height > 0.05

	if env:
		env.background_energy_multiplier = lerpf(0.05, 1.0, daylight)
		env.ambient_light_energy = lerpf(0.15, 1.0, daylight)
