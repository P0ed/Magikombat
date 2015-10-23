import Foundation
import SpriteKit

let tileSize = 32

class PlanetScene: BaseScene {

	var level: PlanetLevel!

	override func becomeFirstResponder() -> Bool {
		appDelegate().eventsController.deviceConfiguration = DeviceConfiguration(
			buttonsMapTable: [
				.Circle: PressAction { appDelegate().navigationController?.popScene() }
			],
			dPadMapTable: [:],
			keyboardMapTable: [:]
		)
		return true
	}

	override func didMoveToView(view: SKView) {

		if level == nil {
//			let dsa = DiamondSquareAlgorithm(seed: 1)
//			let heightMap = dsa.makeHeightMap(3, variation: 14)
//			heightMap.forEach {
//				print($0)
//			}

			let tileMap = TileMapGenerator.generateTileMap()
			level = PlanetLevel(tileMap: tileMap)
		}
		renderTileMap(level.tileMap)
	}

	func renderTileMap(tileMap: TileMap) {
		tileMap.tiles.enumerate().forEach { x in
			x.element.enumerate().forEach { y in

				func tileColor(tile: TileType) -> NSColor {
					switch tile {
					case .Sand: return NSColor(red: 0.9, green: 0.8, blue: 0.3, alpha: 1.0)
					case .Arid: return NSColor(red: 0.7, green: 0.6, blue: 0.4, alpha: 1.0)
					case .Dirt: return NSColor(red: 0.6, green: 0.5, blue: 0.1, alpha: 1.0)
					}
				}

				let node = SKSpriteNode(color: tileColor(y.element.type), size: CGSize(width: tileSize, height: tileSize))
				node.position = CGPoint(
					x: x.index * tileSize + tileSize / 2,
					y: y.index * tileSize + tileSize / 2
				)
				self.addChild(node)
			}
		}
	}
}
