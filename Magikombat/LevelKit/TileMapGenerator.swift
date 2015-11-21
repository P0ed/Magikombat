import Foundation

typealias Position = (x: Int, y: Int)

final class PlatformNode {

	var pos: Position = (x: 0, y: 0)
	var size: Int = 0

	var left: PlatformNode? = nil
	var right: PlatformNode? = nil
	var top: PlatformNode? = nil
	var bottom: PlatformNode? = nil
}

private struct PlatformDimensions {
	var minWidth = 8
	var maxWidth = 32
	var requiredHeight = 16
}

final class TileMapGenerator {

	private let platformDimensions = PlatformDimensions()

	private var platforms: [[PlatformNode]] = []

	var map: TileMap
	var steps: [TileMap] = []

	init(width: Int, height: Int) {
		map = TileMap(width: width, height: height)
	}

	func generateTileMap() -> [TileMap] {

		makeWalls()
		makeFloor()
		makePlatforms()

		return steps
	}

	private func makeWalls() {

		for index in 0..<map.size.height {
			map.setTile(Tile(type: .Wall), at: (0, index))
			map.setTile(Tile(type: .Wall), at: (map.size.width - 1, index))
		}

		steps.append(map)
	}

	private func makeFloor() {

	}

	private func makePlatforms() {
		
	}
}
