import Foundation

class Body {

	enum Type {
		case Static
		case Dynamic
	}

	let bodyRef: BodyRef
	let type: Type

	var position: Vector {
		get {
			return B2DBodyPosition(bodyRef).asVector()
		}
	}

	var velocity: Vector {
		get {
			return B2DBodyVelocity(bodyRef).asVector()
		}
	}

	func applyImpulse(impulse: Vector) {
		B2DBodyApplyImpulse(bodyRef, impulse.asB2DVector())
	}

	init(bodyRef: BodyRef, type: Type) {
		self.bodyRef = bodyRef
		self.type = type
	}
}
