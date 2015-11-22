import Foundation

enum Tile {
	case Wall
	case Platform
}

struct TileMap {

	let size: Size
	var tiles: [Tile?]

	init() {
		size = Size(width: 0, height: 0)
		tiles = []
	}

	init(width: Int, height: Int) {
		size = Size(width: width, height: height)
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
				f(tile: tile, position: Position(x: item.index % size.width, y: item.index / size.width))
			}
		}
	}
}
