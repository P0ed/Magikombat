import Foundation
import BrightFutures

extension MenuModel {
	static let mainMenuModel: MenuModel = {
		let items = [
			MenuItem(title: "New game") {
				Future(value: .Route(.NewGame))
			},
			MenuItem(title: "Options") {
				Future(error: .Nothing)
			},
			MenuItem(title: "Quit game") {
				Future(error: .Nothing)
			}
		]
		return MenuModel.Plain(items: items)
	}()
}
