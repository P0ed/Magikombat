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

		inputController = InputController(appDelegate().eventsController)
		engineController = EngineController()
		renderer = Renderer(world: world)

		let camera = SKCameraNode()
		addChild(camera)
		self.camera = camera
	}

	override func becomeFirstResponder() -> Bool {
		appDelegate().eventsController.deviceConfiguration = DeviceConfiguration(
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
		return true
	}

	override func update(currentTime: Double) {
		renderer.renderState(engineController.stateFromTime(currentTime, input:inputController.currentInput()))
	}
}
