import Foundation

enum TileType {
	case Color(Int)
	case Water
	case Sand
	case Arid
	case Dirt
}

class Tile {

	var type: TileType
	var object: PlanetObject?

	init(type: TileType) {
		self.type = type
	}
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