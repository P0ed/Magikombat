import Foundation

class Engine {

	let world = World()

	init(level: Level) {
		setup(level)
	}

	func setup(level: Level) {

		level.forEach { node in
			let platform = node.platform
			world.createStaticBody(platform.position.asVector(), size: platform.size.asVector())
		}
	}

	func handleInput(input: Input) {
		let dPad = input.dPad.rawValue
		if dPad & DSHatDirection.Left.rawValue != 0 {

		}
		if dPad & DSHatDirection.Right.rawValue != 0 {

		}
		if dPad & DSHatDirection.Up.rawValue != 0 {

		}
		if dPad & DSHatDirection.Down.rawValue != 0 {

		}
	}

	func simulatePhysics(var state: GameState, input: Input) -> GameState {
		handleInput(input)

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
