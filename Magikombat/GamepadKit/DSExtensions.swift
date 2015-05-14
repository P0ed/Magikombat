import Foundation

struct DSVector {
	var dx: Double
	var dy: Double

	init(dx: Double, dy: Double) {
		self.dx = dx
		self.dy = dy
	}

	init() {
		self.init(dx: 0.0, dy: 0.0)
	}

	init(dx: Int, dy: Int) {
		self.init(dx: dx, dy: dy)
	}
}

enum DSControl: UInt {
	case Unknown = 0

	case ButtonSquare = 1
	case ButtonCross = 2
	case ButtonCircle = 3
	case ButtonTriangle = 4

	case ButtonL1 = 5
	case ButtonR1 = 6
	case ButtonL2 = 7
	case ButtonR2 = 8

	case ButtonShare = 9
	case ButtonOptions = 10

	case DPad = 64
}
