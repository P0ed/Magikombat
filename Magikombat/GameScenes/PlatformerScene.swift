import Foundation
import SpriteKit

class PlatformerScene: BaseScene {

	var engineController: EngineController!
	var renderer: Renderer!
	var world: SKNode!
	var inputController: InputController!

	override func didMoveToView(view: SKView) {
		super.didMoveToView(view);

		world = SKNode()
		self.addChild(world)

		let generator = TileMapGenerator(seed: Int(arc4random_uniform(256) + 1), width: 256, height: 64)
		let level = generator.generateLevel()

		let camera = SKCameraNode()
		addChild(camera)
		self.camera = camera

		inputController = InputController(appDelegate().eventsController)
		engineController = EngineController(level: level)
		renderer = Renderer(level: level, world: world, camera: camera)
	}

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

	override func update(currentTime: Double) {
		let input = inputController.currentInput()
		let state = engineController.stateFromTime(currentTime, input:input)
		renderer.renderState(state)
	}
}
