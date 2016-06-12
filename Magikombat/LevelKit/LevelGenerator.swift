import Foundation
import GameplayKit

private struct PlatformDimensions {
	var minWidth = 8
	var maxWidth = 32
	var requiredHeight = 16
}

private let platformDimensions = PlatformDimensions()

final class TileMapGenerator {

	var map: TileMap
	var steps: [TileMap] = []
	
	let random: GKARC4RandomSource

	init(seed: Int, width: Int, height: Int) {

		var seedValue = seed
		let seedData = NSData(bytes: &seedValue, length: sizeof(seedValue.dynamicType))
		random = GKARC4RandomSource(seed: seedData)

		map = TileMap(width: width, height: height)
	}

	func generateLevel() -> Level {

		let walls = makeWalls()
		let floor = makeFloor(walls)
		makePlatforms(floor)

		return Level(rootNode: walls.first!, size: map.size)
	}

	private func makePlatform(at position: Position, length: Int, type: Tile) -> PlatformNode {
		return makePlatform(at: position, size: Size(width: length, height: 1), type: type)
	}

	private func makePlatform(at position: Position, size: Size, type: Tile) -> PlatformNode{
		let platform = Platform(position: position, size: size, type: type)
		platform.forEach {
			map.setTile(type, at: $0)
		}
		return PlatformNode(platform)
	}

	private func makeWalls() -> [PlatformNode] {
		let left = makePlatform(at: Position(x: 0, y: 0), size: Size(width: 8, height: map.size.height), type: .Wall)
		let right = makePlatform(at: Position(x: map.size.width - 8, y: 0), size: Size(width: 8, height: map.size.height), type: .Wall)
		return [left, right]
	}

	private func makeFloor(walls: [PlatformNode]) -> [PlatformNode] {

		let leftWallWidth = walls.first!.platform.size.width
		let rightWallWidth = walls.last!.platform.size.width
		var emptyTiles = map.size.width - leftWallWidth - rightWallWidth
		var floorPlatforms = [PlatformNode]()

		while emptyTiles > platformDimensions.minWidth + platformDimensions.maxWidth {

			let width = platformDimensions.minWidth + random.nextIntWithUpperBound(platformDimensions.maxWidth - platformDimensions.minWidth)

			let platform = makePlatform(at: Position(x: map.size.width - emptyTiles - leftWallWidth, y: 0), length: width, type: .Platform)
			platform.left = floorPlatforms.last ?? walls.first
			floorPlatforms.append(platform)

			emptyTiles -= width
		}

		let lastPlatform = makePlatform(at: Position(x: map.size.width - emptyTiles - leftWallWidth, y: 0), length: emptyTiles, type: .Platform)
		lastPlatform.left = floorPlatforms.last
		lastPlatform.right = walls.last

		return floorPlatforms
	}

	private func makePlatforms(floor: [PlatformNode]) {

		var topPlatforms = floor

		let platformIndex = random.nextIntWithUpperBound(topPlatforms.count)
		let parent = topPlatforms[platformIndex]

		let height = platformDimensions.requiredHeight / 2 + random.nextIntWithUpperBound(platformDimensions.requiredHeight / 2)

		let position = Position(x: parent.platform.position.x, y: parent.platform.position.y + height)
		let platform = makePlatform(at: position, length: parent.platform.size.width, type: .Platform)
		platform.bottom = parent
	}
}
