extends StaticBody3D

func _ready() -> void:
	_add_wall(Vector3(52, 6, 1), Vector3(0, 3, -25))   # north
	_add_wall(Vector3(52, 6, 1), Vector3(0, 3, 25))    # south
	_add_wall(Vector3(1, 6, 52), Vector3(25, 3, 0))    # east
	_add_wall(Vector3(1, 6, 52), Vector3(-25, 3, 0))   # west

func _add_wall(size: Vector3, pos: Vector3) -> void:
	var shape := CollisionShape3D.new()
	var box := BoxShape3D.new()
	box.size = size
	shape.shape = box
	shape.position = pos
	add_child(shape)
