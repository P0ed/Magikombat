import Foundation
import SpriteKit
import BrightFutures

class NavigationController {
	var sceneStack: [BaseScene] = []
	var modalScene: BaseScene?

	let view: SKView

	init(view: SKView) {
		self.view = view
	}

	func presentModalScene(scene: BaseScene) throws {
		if modalScene == nil {
			modalScene = scene
		} else {
			throw FlowError.Nothing
		}
	}

	func pushScene(scene: BaseScene) {
		sceneStack.append(scene)
		showScene(scene)
	}

	func popScene() -> BaseScene? {
		let scene = sceneStack.count > 1 ? sceneStack.popLast() : nil
		showScene(sceneStack.last!)
		return scene
	}

	func showScene(scene: BaseScene) {
		view.presentScene(scene)
		view.window?.makeFirstResponder(scene)

		scene.resolve().map {
			switch $0 {
			case let .Route(segue):
				self.performSegue(segue)
			case let .Menu(model):
				self.pushScene(MenuScene(size: self.view.bounds.size, model: model))
			}
			}.onFailure { _ in
				self.popScene()
		}
	}
}

/// Menus and Alerts extension
extension NavigationController {
	func showMenu(model: MenuModel) -> Future<SceneResult, FlowError> {
		return Future(error: FlowError.Nothing)
	}

	func showAlert<T>() -> Future<T, FlowError> {
		return Future(error: FlowError.Nothing)
	}
}

/// Routing extension
extension NavigationController {
	func showMainMenu() {
		let model = MenuModel.mainMenuModel
		let scene = MenuScene(size: view.bounds.size, model: model)
		pushScene(scene)
	}

	func performSegue(segue: Segue) {
		switch segue {
		case .NewGame:
			let scene = PlanetScene()
			pushScene(scene)
		}
	}
}
