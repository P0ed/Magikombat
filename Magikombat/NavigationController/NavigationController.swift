import Foundation
import SpriteKit
import BrightFutures

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
extension NavigationController {
	func showMenu(model: MenuModel) -> Future<MenuResult, FlowError> {
		return Future(error: FlowError.Nothing)
	}

	func showAlert<T>() -> Future<T, FlowError> {
		return Future(error: FlowError.Nothing)
	}

	func resolveMenu(scene: MenuScene) {
		scene.resolve().map {
			switch $0 {
			case let .Route(segue):
				self.performSegue(segue)
			case let .Menu(model):
				self.pushScene(MenuScene(size: self.view.bounds.size, model: model))
			}
		}.onFailure {
			_ in
			popScene()
		}
	}
}

/// Routing extension
extension NavigationController {
	func showMainMenu() {
		let model = MenuModel.mainMenuModel
		let scene = MenuScene(size: view.bounds.size, model: model)
		pushScene(scene)
		resolveMenu(scene)
	}

	func performSegue(segue: Segue) {
		switch segue {
		case .NewGame:
			let scene = PlanetScene()
			pushScene(scene)
		}
	}
}
