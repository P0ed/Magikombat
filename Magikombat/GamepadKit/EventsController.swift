import Foundation

class EventsController {

	var deviceConfiguration = DeviceConfiguration()

	var leftJoystick = DSVector()
	var rightJoystick = DSVector()
	var leftTrigger = Double()
	var rightTrigger = Double()
	var hatDirection: UInt = 0

	func handleEvent(event: OEHIDEvent) {
		switch event.type.value {
		case OEHIDEventTypeAxis.value:
			switch event.axis.value {
			case OEHIDEventAxisX.value:
				leftJoystick.dx = event.value().native
			case OEHIDEventAxisY.value:
				leftJoystick.dy = event.value().native
			case OEHIDEventAxisZ.value:
				rightJoystick.dx = event.value().native
			case OEHIDEventAxisRz.value:
				rightJoystick.dy = event.value().native
			default: break
			}
		case OEHIDEventTypeTrigger.value:
			switch event.axis.value {
			case OEHIDEventAxisRx.value:
				leftTrigger = event.value().native
			case OEHIDEventAxisRy.value:
				rightTrigger = event.value().native
			default: break
			}
		case OEHIDEventTypeButton.value:
			if let action = deviceConfiguration.actionsMapTable[deviceConfiguration.controlForEvent(event)] {
				action.performAction(Bool(event.state.value))
			}
		case OEHIDEventTypeHatSwitch.value:
			hatDirection = event.hatDirection.value
			if let action = deviceConfiguration.actionsMapTable[deviceConfiguration.controlForEvent(event)] {
				action.performAction(hatDirection)
			}
		default: break
		}
	}
}
