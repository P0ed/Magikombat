import Foundation
import MultipeerConnectivity
import SpriteKit

class PlanetLevel {

	var tileMap: TileMap
	let hero: Hero

	init(tileMap: TileMap) {
		self.tileMap = tileMap

		hero = Hero()
		self.tileMap.tiles[0][0].object = hero
	}
}

extension PlanetLevel {

	class Turn {
		
	}

	class PlayerTurn {

	}
}
