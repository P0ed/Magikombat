import Foundation

class Engine {

	let world = B2DWorld()

	func simulatePhysics(var state: GameState, input: Input) -> GameState {
		switch(input.dPad) {
		case .Left:
			state.hero.position.dx -= 1
		case .Right:
			state.hero.position.dx += 1
		case .Up:
			state.hero.position.dy += 1
		case .Down:
			state.hero.position.dy -= 1
		default: break
		}
		return state
	}
}
