import Foundation
import SpriteKit

class PlatformerScene: BaseScene {

	var engine: Engine!
	var renderer: Renderer!
	var world: SKNode!

	override func didMoveToView(view: SKView) {
		super.didMoveToView(view);

		world = SKNode()
		self.addChild(world)

		engine = Engine()
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

	override func update(currentTime: NSTimeInterval) {
		let state = engine.stateFromTime(currentTime)
		renderer.renderState(state)
	}
}
