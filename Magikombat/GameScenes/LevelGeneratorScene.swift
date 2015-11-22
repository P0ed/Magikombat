import Foundation
import SpriteKit

let tileSize = 32

func delay(delay: Double, on queue: dispatch_queue_t = dispatch_get_main_queue(), closure: ()->()) {
	let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
	dispatch_after(time, queue, closure)
}


final class LevelGeneratorScene: BaseScene {

	var world: SKNode!
	var level: Level?

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

		let generator = TileMapGenerator(seed: 0, width: 256, height: 64)
		let level = generator.generateLevel()
		var platforms = level.allNodes
		self.level = level

		func schedule() {
			renderPlatform(platforms.removeFirst().platform)
			if platforms.count > 0 { delay(0.1, closure: schedule) }
		}
		schedule()
	}

	func renderPlatform(platform: Platform) {

		func tileColor(tile: Tile) -> SKColor {
			switch tile {
			case .Wall: return SKColor(red: 0.8, green: 0.7, blue: 0.3, alpha: 1.0)
			case .Platform: return SKColor(red: 0.4, green: 0.5, blue: 0.5, alpha: 1.0)
			}
		}

		let size = CGSize(width: platform.size.width * tileSize, height: platform.size.height * tileSize)
		let node = SKSpriteNode(color: tileColor(platform.type), size: size)
		node.position = CGPoint(x: platform.position.x * tileSize, y: platform.position.y * tileSize)
		node.anchorPoint = CGPointZero
		world.addChild(node)
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

			func tileColor(tile: Tile) -> SKColor {
				switch tile {
				case .Wall: return SKColor(red: 0.8, green: 0.7, blue: 0.3, alpha: 1.0)
				case .Platform: return SKColor(red: 0.4, green: 0.5, blue: 0.5, alpha: 1.0)
				}
			}

			let node = SKSpriteNode(color: tileColor(tile), size: CGSize(width: tileSize, height: tileSize))
			node.position = CGPoint(x: position.x * tileSize, y: position.y * tileSize)
			node.anchorPoint = CGPointZero
			world.addChild(node)
		}
	}
}
