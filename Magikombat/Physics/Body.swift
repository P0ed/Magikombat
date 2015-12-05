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

	init(bodyRef: BodyRef, type: Type) {
		self.bodyRef = bodyRef
		self.type = type
	}
}
