import Foundation
import SpriteKit

let tileSize = 32

final class LevelGeneratorScene: BaseScene {

	var world: SKNode!
	var stepsQueue: [TileMap]?

	override func controlsMap() -> DeviceConfiguration {
		return DeviceConfiguration(
			buttonsMapTable: [
				.Circle: PressAction { self.promise!.failure(.Nothing) }
			],
			dPadMapTable: [:],
			keyboardMapTable: [
				DeviceConfiguration.keyCodeForVirtualKey(kVK_Delete): PressAction {
					self.promise!.failure(.Nothing)
				}
			]
		)
	}

	override func didMoveToView(view: SKView) {
		scaleMode = .AspectFill

		world = SKNode()
		addChild(world)

		let camera = SKCameraNode()
		addChild(camera)
		self.camera = camera

		camera.position = CGPoint(x: 128 * tileSize, y: 32 * tileSize)
		camera.setScale(8)

		generateMap()
	}

	func generateMap() {
		let generator = TileMapGenerator(width: 256, height: 64)
		stepsQueue = generator.generateTileMap()
		scheduleQueue()
	}

	func scheduleQueue() {
		if var steps = stepsQueue {
			renderTileMap(steps.removeFirst())

			if steps.count > 0 {
				let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
				dispatch_after(dispatchTime, dispatch_get_main_queue(), scheduleQueue)
			}
		}
	}

	override func update(currentTime: NSTimeInterval) {
		// Camera movement
		let dsVector = appDelegate().eventsController.leftJoystick
		if abs(dsVector.dx) + abs(dsVector.dy) > 0.0 {
			let cgVector = CGVector(dx: dsVector.dx * 16, dy: dsVector.dy * 16)
			let moveAction = SKAction.moveBy(cgVector, duration: 0.2)
			self.camera?.runAction(moveAction)
		}

		// Zooming
		var zoom: Double?
		if appDelegate().eventsController.leftTrigger > 0 {
			zoom = 1 + appDelegate().eventsController.leftTrigger / 24.0
		}
		if appDelegate().eventsController.rightTrigger > 0 {
			zoom = 1 - appDelegate().eventsController.rightTrigger / 24.0
		}
		if let zoom = zoom {
			let action = SKAction.scaleBy(CGFloat(zoom), duration: 0.2)
			self.camera?.runAction(action)
		}
	}

	func renderTileMap(tileMap: TileMap) {
		tileMap.forEach { tile, position in

			func tileColor(tile: TileType) -> SKColor {
				switch tile {
				case .Wall: return SKColor(red: 0.8, green: 0.7, blue: 0.3, alpha: 1.0)
				case .Platform: return SKColor(red: 0.4, green: 0.5, blue: 0.5, alpha: 1.0)
				}
			}

			let node = SKSpriteNode(color: tileColor(tile.type), size: CGSize(width: tileSize, height: tileSize))
			node.position = CGPoint(x: position.x * tileSize, y: position.y * tileSize)
			node.anchorPoint = CGPointZero
			self.world.addChild(node)
		}
	}
}
