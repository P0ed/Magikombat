import Foundation

class TileMapGenerator {

	struct Room {
	}

	static func generateTileMap() -> TileMap {

		var tileMap = TileMap()
		tileMap.size = TileMap.Size(width: 30, height:10)

		tileMap.tiles = (0..<tileMap.size.height).map { rowIndex in
			return (0..<tileMap.size.width).map { tileIndex in
				return Tile(type: rowIndex == 0 ? TileType.Dirt : TileType.None)
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
