extends CharacterBody3D

@export var speed := 5.0
@export var turn_speed := 10.0
@export var gravity := 20.0

@onready var model: Node3D = $Model

var facing := Vector3(0, 0, -1)
var facing_tile := Vector2i.ZERO

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := Vector3(input_dir.x, 0.0, input_dir.y)

	if direction.length() > 0.0:
		direction = direction.normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		var target_angle := atan2(-direction.x, -direction.z)
		model.rotation.y = lerp_angle(model.rotation.y, target_angle, turn_speed * delta)
		# Snap facing to the nearest of the 4 directions
		if abs(direction.x) > abs(direction.z):
			facing = Vector3(sign(direction.x), 0, 0)
		else:
			facing = Vector3(0, 0, sign(direction.z))
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed)
		velocity.z = move_toward(velocity.z, 0.0, speed)

	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0.0

	move_and_slide()

	var current_tile := GameGrid.world_to_tile(global_position)
	facing_tile = current_tile + Vector2i(int(facing.x), int(facing.z))
