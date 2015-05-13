import Foundation

class DeviceAction<T> {

	let action: SinkOf<T>

	init(action: SinkOf<T>) {
		self.action = action
	}

	func performAction(value: T) {
		action.put(value)
	}
}
