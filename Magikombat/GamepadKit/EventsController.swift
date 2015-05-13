import Foundation

class EventsController {

	var deviceConfiguration = DeviceConfiguration()

	func handleEvent(event: OEHIDEvent) {
		let action = deviceConfiguration.actionsMapTable[deviceConfiguration.controlForEvent(event)]

		switch event.type.value {
		case OEHIDEventTypeAxis.value:
//			if (event.axis == OEHIDEventAxisX) {
//				_leftJoystick.dx = event.value;
//			}
//			else if (event.axis == OEHIDEventAxisY) {
//				_leftJoystick.dy = event.value;
//			}
//			else if (event.axis == OEHIDEventAxisZ) {
//				_rightJoystick.dx = event.value;
//			}
//			else if (event.axis == OEHIDEventAxisRz) {
//				_rightJoystick.dy = event.value;
//			}
			break
		case OEHIDEventTypeButton.value:
//			[action postEvent:@(event.state)];
//			if (event.state && action) {
//				[_actions setObject:action forKey:@(control)];
//			} else {
//				[_actions removeObjectForKey:@(control)];
//			}
			break
		case OEHIDEventTypeHatSwitch.value:
//			uint8_t previous = _hatDirection & 0xF;
//			uint8_t current = _hatDirection = event.hatDirection & 0xF;
//
//			uint8_t down = ~(previous | ~current) & 0xF;
//			uint8_t up = ~(~previous | current) & 0xF;
//
//			uint8_t input = down << 4 | up;
//			[action postEvent:@(input)];
//
//			if (event.hatDirection && action) {
//				[_actions setObject:action forKey:@(control)];
//			} else {
//				[_actions removeObjectForKey:@(control)];
//			}
			break
		default:
			break
		}
	}
}
