import Foundation
import GameplayKit

class TileMapGenerator {

	static func generateTileMap() -> TileMap {

		var tileMap = TileMap()
		tileMap.size = TileMap.Size(width: 65, height:65)

		let dsa = DiamondSquareAlgorithm()
		let heightMap = dsa.makeHeightMap(7, variation: 22)

		tileMap.tiles = (0 ..< tileMap.size.width).map { x in
			return (0 ..< tileMap.size.height).map { y in
				let height = heightMap[x][y]
				return Tile(type: tileTypeFromHeight(height))
			}
		}

		return tileMap
	}

	static func tileTypeFromHeight(height: Int) -> TileType {
		return .Color(height)
//		switch height {
//		case _ where height < -7: return .Water
//		case -7...0: return .Sand
//		case 1...5: return .Arid
//		default: return .Dirt
//		}
	}
}

class DiamondSquareAlgorithm {

	var map: [[Int]] = []
	let random: GKARC4RandomSource

	init() {
		random = GKARC4RandomSource()
	}

	init(seed: Int) {
		var seedValue = seed.value
		let seedData = NSData(bytes: &seedValue, length: sizeof(seedValue.dynamicType))
		random = GKARC4RandomSource(seed: seedData)
	}

	func makeHeightMap(iterations: Int, var variation: Int) -> [[Int]] {
		guard iterations > 0 && variation >= 0 else {
			return [];
		}

		var size = (1 << iterations) + 1
		map = Array(count: size, repeatedValue: Array(count:size, repeatedValue:0))
		let maxIndex = map.endIndex

		for (var i = 1; i <= iterations; i++) {
			// Minimum coordinate of the
			// current map spaces
			// = maxIndex / 2^i
			let minCoordinate = maxIndex >> i;

			// Area surrounding the current place in
			// the map
			size = minCoordinate << 1;

			diamondStep(minCoordinate, size, variation);
			squareStepEven(minCoordinate, size, maxIndex, variation);
			squareStepOdd(minCoordinate, size, maxIndex, variation);

			// Divide variation by 2
			variation = variation >> 1;
		}

		return map
	}

	private func diamondStep(minCoordinate: Int, _ size: Int, _ variation: Int) {
		for var x = minCoordinate; x < map.count - minCoordinate; x += size {
			for var y = minCoordinate; y < map.count - minCoordinate; y += size {

				let left = x - minCoordinate;
				let right = x + minCoordinate;
				let up = y - minCoordinate;
				let down = y + minCoordinate;

				// the four corner values
				let val1 = map[left][up];		// upper left
				let val2 = map[left][down];		// lower left
				let val3 = map[right][up];		// upper right
				let val4 = map[right][down];	// lower right

				calculateAndInsertAverage((val1, val2, val3, val4), variation: variation, point: (x, y));
			}
		}
	}

	private func squareStepEven(minCoordinate: Int, _ size: Int, _ maxIndex: Int, _ variation: Int) {
		for var x = minCoordinate; x < map.count; x += size {
			for var y = 0; y < map.count; y += size {

				let left = (maxIndex + x - minCoordinate) % maxIndex;
				let right = (x + minCoordinate) % maxIndex;
				let down = (y + minCoordinate) % maxIndex;
				let up = (maxIndex + y - minCoordinate) % maxIndex;

				// the four corner values
				let val1 = map[left][y];	// left
				let val2 = map[x][up];		// up
				let val3 = map[right][y];	// right
				let val4 = map[x][down];	// down

				calculateAndInsertAverage((val1, val2, val3, val4), variation: variation, point: (x, y));
			}
		}
	}

	private func squareStepOdd(minCoordinate: Int, _ size: Int, _ maxIndex: Int, _ variation: Int) {
		for var x = 0; x < map.count; x += size {
			for var y = minCoordinate; y < map.count; y += size {
				if x == maxIndex {
					map[x][y] = map[0][y];
					continue;
				}

				let left = (maxIndex + x - minCoordinate) % maxIndex;
				let right = (x + minCoordinate) % maxIndex;
				let down = (y + minCoordinate) % maxIndex;
				let up = (maxIndex + y - minCoordinate) % maxIndex;

				// the four corner values
				let val1 = map[left][y];	// left
				let val2 = map[x][up];		// up
				let val3 = map[right][y];	// right
				let val4 = map[x][down];	// down

				calculateAndInsertAverage((val1, val2, val3, val4), variation: variation, point: (x, y));
			}
		}
	}

	private func calculateAndInsertAverage(values: (Int, Int, Int, Int), variation: Int, point: (Int, Int)) {
		let (v1, v2, v3, v4) = values
		let (x, y) = point

		let avg = (v1 + v2 + v3 + v4) >> 2; // average
		let rnd = Int((random.nextUniform() * Float((variation << 1) + 1))) - variation;
		map[x][y] = avg + rnd;
	}
}
