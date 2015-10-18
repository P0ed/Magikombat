import Foundation
import SpriteKit

class NavigationController {
	var sceneStack: [SKScene] = []
	var modalScene: SKScene?

	let view: SKView

	init(view: SKView) {
		self.view = view
	}

	func presentModalScene(scene: SKScene) throws {
		if modalScene == nil {
			modalScene = scene
		} else {
			throw FlowError.Nothing
		}
	}

	func pushScene(scene: SKScene) {
		sceneStack.append(scene)
		view.presentScene(scene)
		view.window?.makeFirstResponder(scene)
	}

	func popScene() -> SKScene? {
		let scene = sceneStack.popLast()
		view.presentScene(sceneStack.last)
		return scene
	}
}

/// Menus and Alerts extension
//extension NavigationController {
//	func showMenu(model: MenuModel) -> Promise<MenuResult, FlowError> {
//		return SignalProducer(error: FlowError.Nothing)
//	}
//
//	func showAlert<T>() -> Promise<T, FlowError> {
//		return SignalProducer(error: FlowError.Nothing)
//	}
//}

/// Routing extension
extension NavigationController {
	func showMainMenu() {
		pushScene(MenuScene(size: view.bounds.size, model: MenuModel.mainMenuModel))
	}
}
