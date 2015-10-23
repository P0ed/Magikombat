import Foundation
import SpriteKit

class PlanetScene: SKScene {

	var level: PlanetLevel?

	override func didMoveToView(view: SKView) {

		if level == nil {
			let dsa = DiamondSquareAlgorithm(seed: 1)
			let heightMap = dsa.makeHeightMap(3, variation: 14)
			heightMap.forEach {
				print($0)
			}

			let tileMap = TileMapGenerator.generateTileMap()
			level = PlanetLevel(tileMap: tileMap)
		}
	}
}
