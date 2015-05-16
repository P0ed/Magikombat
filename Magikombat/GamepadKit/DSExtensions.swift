import Foundation

struct DSVector {
	var dx: Double
	var dy: Double

	static let zeroVector = DSVector(dx: 0.0, dy: 0.0)
}

enum DSButton: UInt {
	case Square = 1
	case Cross = 2
	case Circle = 3
	case Triangle = 4
	case L1 = 5
	case R1 = 6
	case L2 = 7
	case R2 = 8
	case Share = 9
	case Options = 10
}

enum DSStick {
	case Left
	case Right
}

enum DSTrigger {
	case Left
	case Right
}

enum DSHatDirection: UInt {
	case Null		= 0
	case North		= 1
	case East		= 2
	case South		= 4
	case West		= 8
	case NorthEast	= 3
	case SouthEast	= 6
	case NorthWest	= 9
	case SouthWest	= 12
}

enum DSControl {
	case Button(DSButton)
	case Stick(DSStick)
	case Trigger(DSTrigger)
	case DPad(DSHatDirection)
}
