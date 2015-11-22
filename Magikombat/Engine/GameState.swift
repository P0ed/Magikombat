import Foundation

struct Vector {
	var dx: Float
	var dy: Float

	static let zeroVector = Vector(dx: 0, dy: 0)
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
