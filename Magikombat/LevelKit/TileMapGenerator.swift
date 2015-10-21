import Foundation

class TileMapGenerator {

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
}
