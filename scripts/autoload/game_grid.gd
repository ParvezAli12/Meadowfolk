extends Node

const TILE_SIZE := 1.0

func world_to_tile(pos: Vector3) -> Vector2i:
	return Vector2i(floori(pos.x / TILE_SIZE), floori(pos.z / TILE_SIZE))

func tile_to_world(tile: Vector2i) -> Vector3:
	return Vector3((tile.x + 0.5) * TILE_SIZE, 0.0, (tile.y + 0.5) * TILE_SIZE)
