import Foundation
import BrightFutures

enum MenuResult {
	case Menu(MenuModel)
	case Route(Segue)
}

class MenuItem {
	let title: String
	let action: () -> Future<MenuResult, FlowError>

	init(title: String, action: () -> Future<MenuResult, FlowError>) {
		self.title = title
		self.action = action
	}
}

enum MenuModel {
	case Plain(items: [MenuItem])
}
