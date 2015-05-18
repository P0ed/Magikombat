import Foundation

class TileMapGenerator {

	struct Room {
	}

	static func generateTileMap() -> TileMap {

		var tileMap = TileMap()
		tileMap.size = TileMap.Size(width: 30, height:10)

		for rowIndex in 0..<tileMap.size.height {
			for tileIndex in 0..<tileMap.size.width {
				let type = rowIndex == 0 ? TileType.Dirt : TileType.None
				tileMap.tiles[rowIndex][tileIndex] = Tile(type: type)
			}
		}

		return tileMap
	}

	static func generateRooms() -> [Room] {
		return []
	}

	static func fillRoom(room: Room) {}

	static func setupFloor(room: Room) {}

	static func setupRandomWalls(room: Room) {}

	static func setupRequiredWalls(room: Room) {}

	static func setupLadders(room: TileMap) {}
}
