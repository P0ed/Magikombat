import Foundation

struct Input {
	var dPad: DSHatDirection = .Null
	var jump: Bool = false
}

class InputController {

	let eventsController: EventsController

	init(_ eventsController: EventsController) {
		self.eventsController = eventsController
	}

	func currentInput() -> Input {
		var input = Input()
		input.dPad = eventsController.hatDirection
		return input
	}
}
