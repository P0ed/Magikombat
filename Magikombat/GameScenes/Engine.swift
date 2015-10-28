import Foundation

class Engine {

	var currentTick: Int = 0
	var stateBuffer: [(tick: Int, state: GameState)] = []

	init() {

	}

	func startGame() {
		currentTick = 0
	}

	func stateFromTime(time: NSTimeInterval) -> GameState {
		return GameState()
	}
}