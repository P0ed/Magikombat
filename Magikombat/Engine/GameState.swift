import Foundation

struct Vector {
	var dx: Float
	var dy: Float

	static let zeroVector = Vector(dx: 0, dy: 0)

	func asB2DVector() -> B2DVector {
		return B2DVector(dx: dx, dy: dy)
	}
}

extension B2DVector {
	func asVector() -> Vector {
		return Vector(dx: dx, dy: dy)
	}
}

struct ActorState {
	var position: Vector
	var velocity: Vector
}

struct GameState {
	var hero: ActorState

	init() {
		hero = ActorState(position: Vector.zeroVector, velocity: Vector.zeroVector)
	}
}
