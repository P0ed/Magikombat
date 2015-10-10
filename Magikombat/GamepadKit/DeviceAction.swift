import Foundation

class DeviceAction<T> {

	let action: (T) -> ()

	init(_ action: (T) -> ()) {
		self.action = action
	}

	func performAction(value: T) {
		action(value)
	}
}
