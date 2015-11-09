import Foundation
import SpriteKit
import BrightFutures

class BaseScene: SKScene {
	var promise: Promise<SceneResult, FlowError>?

	func resolve() -> Future<SceneResult, FlowError> {
		promise = Promise()
		return promise!.future
	}

	override func becomeFirstResponder() -> Bool {
		appDelegate().eventsController.deviceConfiguration = controlsMap()
		return true
	}

	/// Фиксит звук непохендленной клавиатуры
	override func keyDown(theEvent: NSEvent) {}
	override func keyUp(theEvent: NSEvent) {}

	func controlsMap() -> DeviceConfiguration {
		return DeviceConfiguration(buttonsMapTable: [:], dPadMapTable: [:], keyboardMapTable: [:])
	}
}
