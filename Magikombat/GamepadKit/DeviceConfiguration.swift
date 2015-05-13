import Foundation

class DeviceConfiguration {

	var actionsMapTable = [Int: DeviceAction<AnyObject>]()

	func controlForEvent(event: OEHIDEvent) -> Int {
		return 0
	}
}
