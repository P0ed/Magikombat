import Foundation

enum TileType {
	case Wall
	case Platform
}

struct Tile {
	let type: TileType
}

struct TileMap {

	struct Size {
		var width: Int
		var height: Int
	}

	let size: TileMap.Size
	var tiles: [Tile?]

	init() {
		size = TileMap.Size(width: 0, height: 0)
		tiles = []
	}

	init(width: Int, height: Int) {
		size = TileMap.Size(width: width, height: height)
		tiles = Array(count: size.width * size.height, repeatedValue: nil)
	}

	mutating func setTile(tile: Tile?, at position: Position) {
		tiles[position.y * size.width + position.x] = tile
	}

	func tileAt(position: Position) -> Tile? {
		return tiles[position.y * size.width + position.x]
	}

	func forEach(@noescape f: (tile: Tile, position: Position) -> ()) {
		tiles.enumerate().forEach { item in
			if let tile = item.element {
				f(tile: tile, position: (x: item.index % size.width, y: item.index / size.width))
			}
		}
	}
}
