import Foundation

struct DeviceConfiguration {

	var buttonsMapTable: [DSButton: DeviceAction<Bool>] = [:]
	var dPadMapTable: [DSHatDirection: DeviceAction<Bool>] = [:]
	var dPadAction: DeviceAction<DSHatDirection>?
	var keyboardMapTable: [Int: DeviceAction<Bool>] = [:]

	static func keyCodeForVirtualKey(virtualKey: Int) -> Int {
		return Int(OEHIDEvent.keyCodeForVirtualKey(CGCharCode(virtualKey)))
	}
}
