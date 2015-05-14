import Foundation

class DeviceConfiguration {

	var actionsMapTable = [DSControl: DeviceAction<AnyObject>]()

	func controlForEvent(event: OEHIDEvent) -> DSControl {
		return .Unknown
	}
}
