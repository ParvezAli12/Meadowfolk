extends Camera3D

@export var offset := Vector3(0, 7, 7)
@export var follow_speed := 5.0

var target: Node3D

func _ready() -> void:
	top_level = true
	target = get_tree().current_scene.get_node_or_null("Player")
	if target == null:
		push_error("Camera could not find a node named 'Player' in the main scene")
		return
	global_position = target.global_position + offset

func _process(delta: float) -> void:
	if target == null:
		return
	var goal := target.global_position + offset
	global_position = global_position.lerp(goal, follow_speed * delta)
