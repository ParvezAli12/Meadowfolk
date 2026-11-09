extends MeshInstance3D

var player: Node3D

func _ready() -> void:
	top_level = true
	player = get_tree().current_scene.get_node("Player")

func _process(_delta: float) -> void:
	global_position = GameGrid.tile_to_world(player.facing_tile) + Vector3(0, 0.03, 0)
