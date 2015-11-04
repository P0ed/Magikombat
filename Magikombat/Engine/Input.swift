import Foundation

struct Input {

}

class InputController {

	let eventsController: EventsController

	init(_ eventsController: EventsController) {
		self.eventsController = eventsController
	}

	func currentInput() -> Input {
		return Input()
	}
}
