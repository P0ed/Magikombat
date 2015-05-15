import Foundation

class DeviceAction<T> {

	let action: SinkOf<T>

	init(_ action: (T) -> ()) {
		self.action = SinkOf<T>(action)
	}

	func performAction(value: T) {
		action.put(value)
	}
}
