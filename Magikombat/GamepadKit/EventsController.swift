import Foundation

class EventsController {

	var deviceConfiguration = DeviceConfiguration()

	var leftJoystick = DSVector.zeroVector
	var rightJoystick = DSVector.zeroVector
	var leftTrigger = Double()
	var rightTrigger = Double()
	var hatDirection = DSHatDirection.Null

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
			if let button = DSButton(rawValue: event.buttonNumber), action = deviceConfiguration.buttonsMapTable[button] {
				action.performAction(Bool(event.state.value))
			}
		case OEHIDEventTypeHatSwitch.value:
			if let hatDirection = DSHatDirection(rawValue: event.hatDirection.value) {
				let buttons = changedStateDPadButtons(self.hatDirection, hatDirection)
				self.hatDirection = hatDirection

				func performActions(buttons: [DSHatDirection], pressed: Bool) {
					for button in buttons {
						if let action = deviceConfiguration.dPadMapTable[button] {
							action.performAction(pressed)
						}
					}
				}

				performActions(buttons.up, false)
				performActions(buttons.down, true)

				if let action = deviceConfiguration.dPadAction {
					action.performAction(hatDirection)
				}
			}
		case OEHIDEventTypeKeyboard.value:
			if let action = deviceConfiguration.keyboardMapTable[event.keycode] {
				action.performAction(Bool(event.state.value))
			}
		default: break
		}
	}

	func controlForEvent(event: OEHIDEvent) -> DSControl? {
		var control: DSControl?

		switch event.type.value {
		case OEHIDEventTypeAxis.value:
			if event.axis.value == OEHIDEventAxisX.value || event.axis.value == OEHIDEventAxisY.value {
				control = .Stick(.Left)
			} else if event.axis.value == OEHIDEventAxisZ.value || event.axis.value == OEHIDEventAxisRz.value {
				control = .Stick(.Right)
			}
		case OEHIDEventTypeTrigger.value:
			if event.axis.value == OEHIDEventAxisRx.value {
				control = .Trigger(.Left)
			} else if event.axis.value == OEHIDEventAxisRy.value {
				control = .Trigger(.Right)
			}
		case OEHIDEventTypeButton.value:
			if let button = DSButton(rawValue: event.buttonNumber) {
				control = .Button(button)
			}
		case OEHIDEventTypeHatSwitch.value:
			if let hatDirection = DSHatDirection(rawValue: event.hatDirection.value) {
				control = .DPad(hatDirection)
			}
		default: break
		}
		return control
	}
}

func changedStateDPadButtons(previous: DSHatDirection, current: DSHatDirection) -> (up: [DSHatDirection], down: [DSHatDirection]) {

	return ([], [])
}
