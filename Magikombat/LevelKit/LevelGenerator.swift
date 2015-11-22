import Foundation
import GameplayKit

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
			map.setTile(.Wall, at: Position(x: 0, y: index))
			map.setTile(.Wall, at: Position(x: map.size.width - 1, y: index))
		}
	}

	private func makePlatform(at position: Position, length: Int, type: Tile) -> PlatformNode {

		for index in 0..<length {
			map.setTile(type, at: Position(x: position.x + index, y: position.y))
		}

		return PlatformNode(platform: Platform(position: position, size: Size(width: length, height: 1), type: type))
	}

	private func makeFloor() {

		var emptyTiles = map.size.width - 2
		var floorPlatforms = [PlatformNode]()

		while emptyTiles > platformDimensions.minWidth + platformDimensions.maxWidth {

			let width = platformDimensions.minWidth + random.nextIntWithUpperBound(platformDimensions.maxWidth - platformDimensions.minWidth)

			let platform = makePlatform(at: Position(x: map.size.width - emptyTiles - 1, y: 0), length: width, type: .Wall)
			platform.left = floorPlatforms.last
			floorPlatforms.last?.right = platform

			floorPlatforms.append(platform)

			emptyTiles -= width
		}

		let lastPlatform = makePlatform(at: Position(x: map.size.width - emptyTiles - 1, y: 0), length: emptyTiles, type: .Wall)
		lastPlatform.left = floorPlatforms.last
		floorPlatforms.last?.right = lastPlatform

		platforms.append(floorPlatforms)
	}

	private func makePlatforms() {

		let topPlatforms = platforms.last!

		let platformIndex = random.nextIntWithUpperBound(topPlatforms.count)
		let parent = topPlatforms[platformIndex]

		let height = platformDimensions.requiredHeight / 2 + random.nextIntWithUpperBound(platformDimensions.requiredHeight / 2)

		let position = Position(x: parent.platform.position.x, y: parent.platform.position.y + height)
		let platform = makePlatform(at: position, length: parent.platform.size.width, type: .Platform)
		platform.bottom = parent
		parent.top = platform
	}
}
