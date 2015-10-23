import Foundation
import SpriteKit

let tileSize = 32

class PlanetScene: BaseScene {

	var level: PlanetLevel!

	var world: SKNode!

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
			let tileMap = TileMapGenerator.generateTileMap()
			level = PlanetLevel(tileMap: tileMap)

			world = SKNode()
			addChild(world)

			let camera = SKCameraNode()
			camera.position = CGPoint(x: 128, y: 128)
			addChild(camera)
			self.camera = camera

			renderTileMap(level.tileMap)
		}
	}

	override func update(currentTime: NSTimeInterval) {
		let dsVector = appDelegate().eventsController.leftJoystick
		let cgVector = CGVector(dx: dsVector.dx * 6, dy: dsVector.dy * 6)
		let moveAction = SKAction.moveBy(cgVector, duration: 0.2)
		self.camera?.runAction(moveAction)
	}

//	func dsa() {
//		let dsa = DiamondSquareAlgorithm(seed: 1)
//		let heightMap = dsa.makeHeightMap(3, variation: 14)
//		heightMap.forEach {
//			print($0)
//		}
//	}

	func renderTileMap(tileMap: TileMap) {
		tileMap.tiles.enumerate().forEach { x in
			x.element.enumerate().forEach { y in

				func tileColor(tile: TileType) -> NSColor {
					switch tile {
					case .Water: return NSColor(red: 0.1, green: 0.3, blue: 0.8, alpha: 1.0)
					case .Sand: return NSColor(red: 0.9, green: 0.8, blue: 0.3, alpha: 1.0)
					case .Arid: return NSColor(red: 0.7, green: 0.6, blue: 0.4, alpha: 1.0)
					case .Dirt: return NSColor(red: 0.6, green: 0.5, blue: 0.1, alpha: 1.0)
					}
				}

				let node = SKSpriteNode(color: tileColor(y.element.type), size: CGSize(width: tileSize, height: tileSize))
				node.position = CGPoint(
					x: x.index * tileSize,
					y: y.index * tileSize
				)
				node.anchorPoint = CGPoint(x: 0, y: 0)
				world.addChild(node)
			}
		}
	}
}
