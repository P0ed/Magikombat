import Foundation
import BrightFutures

extension MenuModel {
	static let mainMenuModel: MenuModel = {
		let items = [
			MenuItem(title: "New game") {
				return Future(value: MenuResult.Nothing)
			},
			MenuItem(title: "Options") {
				return Future(value: MenuResult.Nothing)
			},
			MenuItem(title: "Quit game") {
				return Future(value: MenuResult.Nothing)
			}
		]
		return MenuModel.Plain(items: items)
	}()
}
