import Foundation

class Body {

	enum Type {
		case Static
		case Dynamic
	}

	let bodyRef: BodyRef
	let type: Type

	init(bodyRef: BodyRef, type: Type) {
		self.bodyRef = bodyRef
		self.type = type
	}
}
