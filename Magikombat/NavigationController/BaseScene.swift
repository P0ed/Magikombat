import Foundation
import SpriteKit
import BrightFutures

class BaseScene: SKScene {
	var promise: Promise<SceneResult, FlowError>?

	func resolve() -> Future<SceneResult, FlowError> {
		promise = Promise()
		return promise!.future
	}
}
