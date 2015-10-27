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
			keyboardMapTable: [
				DeviceConfiguration.keyCodeForVirtualKey(kVK_Delete): PressAction {
					self.promise!.failure(.Nothing)
				}
			]
		)
		return true
	}

	override func didMoveToView(view: SKView) {
		if level == nil {
			scaleMode = .AspectFill

			let tileMap = TileMapGenerator.generateTileMap()
			level = PlanetLevel(tileMap: tileMap)

			world = SKNode()
			addChild(world)

			let camera = SKCameraNode()
			camera.position = CGPoint(x: 256, y: 256)
			addChild(camera)
			self.camera = camera

			renderTileMap(level.tileMap)
		}
	}

	override func update(currentTime: NSTimeInterval) {
		// Camera movement
		let dsVector = appDelegate().eventsController.leftJoystick
		if abs(dsVector.dx) + abs(dsVector.dy) > 0.0 {
			let cgVector = CGVector(dx: dsVector.dx * 10, dy: dsVector.dy * 10)
			let moveAction = SKAction.moveBy(cgVector, duration: 0.2)
			self.camera?.runAction(moveAction)
		}

		// Zooming
		var zoom: Double?
		if appDelegate().eventsController.leftTrigger > 0 {
			zoom = 1 + appDelegate().eventsController.leftTrigger / 16.0
		}
		if appDelegate().eventsController.rightTrigger > 0 {
			zoom = 1 - appDelegate().eventsController.rightTrigger / 16.0
		}
		if let zoom = zoom {
			let action = SKAction.scaleBy(CGFloat(zoom), duration: 0.2)
			self.camera?.runAction(action)
		}
	}

	func renderTileMap(tileMap: TileMap) {
		tileMap.tiles.enumerate().forEach { x in
			x.element.enumerate().forEach { y in

				func tileColor(tile: TileType) -> SKColor {
					switch tile {
					case .Color(let height):
						let h = CGFloat(height + 20) / 40.0
						return SKColor(red: h, green: 0.2 + h / 2.0, blue: h / 4.0, alpha: 1.0)
					case .Water: return SKColor(red: 0.1, green: 0.3, blue: 0.8, alpha: 1.0)
					case .Sand: return SKColor(red: 0.9, green: 0.8, blue: 0.3, alpha: 1.0)
					case .Arid: return SKColor(red: 0.7, green: 0.6, blue: 0.4, alpha: 1.0)
					case .Dirt: return SKColor(red: 0.6, green: 0.5, blue: 0.1, alpha: 1.0)
					}
				}

				let node = SKSpriteNode(color: tileColor(y.element.type), size: CGSize(width: tileSize, height: tileSize))
				node.position = CGPoint(x: x.index * tileSize, y: y.index * tileSize)
				node.anchorPoint = CGPointZero
				world.addChild(node)
			}
		}
	}
}
