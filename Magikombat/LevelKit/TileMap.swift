import Foundation

enum TileType {
	case Sand
	case Arid
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
	var tiles: [[Tile]]

	init() {
		size = TileMap.Size(width: 0, height: 0)
		tiles = []
	}

	func calculateWalkPath() {}
}