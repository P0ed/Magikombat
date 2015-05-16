import Foundation

class DeviceConfiguration {

	var buttonsMapTable = [DSButton: DeviceAction<Bool>]()
	var dPadMapTable = [DSHatDirection: DeviceAction<Bool>]()
	var dPadAction: DeviceAction<DSHatDirection>?
	var keyboardMapTable = [UInt: DeviceAction<Bool>]()
}
