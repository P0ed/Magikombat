import Foundation
import BrightFutures

enum SceneResult {
	case Menu(MenuModel)
	case Route(Segue)
}

class MenuItem {
	let title: String
	let action: () -> Future<SceneResult, FlowError>

	init(title: String, action: () -> Future<SceneResult, FlowError>) {
		self.title = title
		self.action = action
	}
}

enum MenuModel {
	case Plain(items: [MenuItem])
}
