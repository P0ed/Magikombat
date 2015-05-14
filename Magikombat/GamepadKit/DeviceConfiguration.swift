import Foundation

class DeviceConfiguration {

	var actionsMapTable = [DSControl: DeviceAction<AnyObject>]()

	func controlForEvent(event: OEHIDEvent) -> DSControl {
		var control = DSControl.Unknown

		switch event.type.value {
		case OEHIDEventTypeAxis.value:
			if event.axis.value == OEHIDEventAxisX.value || event.axis.value == OEHIDEventAxisY.value {
				control = .StickLeft
			} else if event.axis.value == OEHIDEventAxisZ.value || event.axis.value == OEHIDEventAxisRz.value {
				control = .StickRight
			}
		case OEHIDEventTypeTrigger.value:
			if event.axis.value == OEHIDEventAxisRx.value {
				control = .TriggerLeft
			} else if event.axis.value == OEHIDEventAxisRy.value {
				control = .TriggerRight
			}
		case OEHIDEventTypeButton.value:
			control = DSControl(rawValue: event.buttonNumber)!
		case OEHIDEventTypeHatSwitch.value:
			control = .DPad
		default: break
		}
		return control
	}
}
