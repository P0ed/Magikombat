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

class DiamondSquareAlgorithm {

	var map: [[Int]] = []

	/**
	* This method uses the seed value to initialize the four corners of the
	* map. The variation creates randomness in the map. The size of the array
	* is determined by the amount of iterations (i.e. 1 iteration -> 3x3 array,
	* 2 iterations -> 5x5 array, etc.).
	*
	* @param iterations
	*            the amount of iterations to do (minimum of 1)
	* @param seed
	*            the starting value
	* @param variation
	*            the amount of randomness in the height map (minimum of 0)
	* @return a height map in the form of a 2-dimensional array containing
	*         integer values or null if the arguments are out of range
	*/
	func makeHeightMap(iterations: Int, seed: Int, var variation: Int) -> [[Int]] {
		guard iterations > 0 && variation >= 0 else {
			return [];
		}

		var size = (1 << iterations) + 1
		map = Array(count: size, repeatedValue: Array(count:size, repeatedValue:0))
		let maxIndex = map.endIndex

		map[0][0] = seed;
		map[0][maxIndex] = seed;
		map[maxIndex][0] = seed;
		map[maxIndex][maxIndex] = seed;

		for (var i = 1; i <= iterations; i++) {
			// Minimum coordinate of the
			// current map spaces
			let minCoordinate = maxIndex >> i;

			// Area surrounding the current place in
			// the map
			size = minCoordinate << 1;


			diamondStep(minCoordinate, size, &map, variation);
			squareStepEven(minCoordinate, &map, size, maxIndex, variation);
			squareStepOdd(&map, size, minCoordinate, maxIndex, variation);

			// Divide variation by 2
			variation = variation >> 1;
		}

		return map
	}

	/**
	* Calculates average values of four corner values taken from the smallest
	* possible square.
	*
	* @param minCoordinate
	*            the x and y coordinate of the first square center
	* @param size
	*            width and height of the squares
	* @param map
	*            the height map to fill
	* @param variation
	*            the randomness in the height map
	*/
	private func diamondStep(minCoordinate: Int, _ size: Int, inout _ map: [[Int]], _ variation: Int) {

	}

	/**
	* Calculates average values of four corner values taken from the smallest
	* possible diamond. This method calculates the values for the even rows,
	* starting with row 0.
	*
	* @param minCoordinate
	*            the x-coordinate of the first diamond center
	* @param map
	*            the height map to fill
	* @param size
	*            the length of the diagonals of the diamonds
	* @param maxIndex
	*            the maximum index in the array
	* @param variation
	*            the randomness in the height map
	*/
	private func squareStepEven(minCoordinate: Int, inout _ map: [[Int]], _ size: Int, _ maxIndex: Int, _ variation: Int) {

	}

	/**
	* Calculates average values of four corner values taken from the smallest
	* possible diamond. This method calculates the values for the odd rows,
	* starting with row 1.
	*
	* @param minCoordinate
	*            the x-coordinate of the first diamond center
	* @param map
	*            the height map to fill
	* @param size
	*            the length of the diagonals of the diamonds
	* @param maxIndex
	*            the maximum index in the array
	* @param variation
	*            the randomness in the height map
	*/
	private func squareStepOdd(inout map: [[Int]], _ size: Int, _ minCoordinate: Int, _ maxIndex: Int, _ variation: Int) {

	}

	/**
	* Calculates an average value, adds a variable amount to that value and
	* inserts it into the height map.
	*
	* @param val1
	*            first of the values used to calculate the average
	* @param val2
	*            second of the values used to calculate the average
	* @param val3
	*            third of the values used to calculate the average
	* @param val4
	*            fourth of the values used to calculate the average
	* @param variation
	*            adds variation to the average value
	* @param map
	*            the height map to fill
	* @param x
	*            the x-coordinate of the place to fill
	* @param y
	*            the y-coordinate of the place to fill
	*/
	private func calculateAndInsertAverage(val1: Int, val2: Int, val3: Int, val4: Int, variation: Int, map: [[Int]], x: Int, y: Int) {

	}
}
