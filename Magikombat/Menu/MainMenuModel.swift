import Foundation
import BrightFutures

extension MenuModel {
	static let mainMenuModel: MenuModel = {
		let items = [
			MenuItem(title: "New game") {
				return Future(value: .Route(.NewGame))
			},
			MenuItem(title: "Options") {
				return Future(error: .Nothing)
			},
			MenuItem(title: "Quit game") {
				return Future(error: .Nothing)
			}
		]
		return MenuModel.Plain(items: items)
	}()
}
