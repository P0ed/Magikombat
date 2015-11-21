import Foundation
import GameplayKit

typealias Position = (x: Int, y: Int)

final class PlatformNode {

	var position: Position = (x: 0, y: 0)
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
	
	let random: GKARC4RandomSource

	init(seed: Int, width: Int, height: Int) {

		var seedValue = seed.value
		let seedData = NSData(bytes: &seedValue, length: sizeof(seedValue.dynamicType))
		random = GKARC4RandomSource(seed: seedData)

		map = TileMap(width: width, height: height)
	}

	func generateTileMap() -> [TileMap] {

		makeWalls()
		makeFloor()
		makePlatforms()

		return [map]
	}

	private func makeWalls() {

		for index in 0..<map.size.height {
			map.setTile(Tile(type: .Wall), at: (0, index))
			map.setTile(Tile(type: .Wall), at: (map.size.width - 1, index))
		}
	}

	private func makePlatform(at position: Position, size: Int, type: TileType) -> PlatformNode {

		let node = PlatformNode()
		node.position = position
		node.size = size

		for index in 0..<size {
			map.setTile(Tile(type: type), at: (position.x + index, position.y))
		}

		return node
	}

	private func makeFloor() {

		var emptyTiles = map.size.width - 2
		var floorPlatforms = [PlatformNode]()

		while emptyTiles > platformDimensions.minWidth + platformDimensions.maxWidth {

			let width = platformDimensions.minWidth + random.nextIntWithUpperBound(platformDimensions.maxWidth - platformDimensions.minWidth)

			let platform = makePlatform(at: (map.size.width - emptyTiles - 1, 0), size: width, type: .Wall)
			platform.left = floorPlatforms.last
			floorPlatforms.last?.right = platform

			floorPlatforms.append(platform)

			emptyTiles -= width
		}

		let lastPlatform = makePlatform(at: (map.size.width - emptyTiles - 1, 0), size: emptyTiles, type: .Wall)
		lastPlatform.left = floorPlatforms.last
		floorPlatforms.last?.right = lastPlatform

		platforms.append(floorPlatforms)
	}

	private func makePlatforms() {
		
	}
}
