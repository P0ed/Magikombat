import Foundation

enum TileType {
	case None
	case Dirt
}

struct Tile {

	var type: TileType
}

struct TileMap {

	struct Size {
		var width: Int
		var height: Int
	}

	var size: TileMap.Size
	var tiles: Array<Array<Tile>>

	init() {
		size = TileMap.Size(width: 0, height: 0)
		tiles = []
	}

	func calculateWalkPath() {}
}