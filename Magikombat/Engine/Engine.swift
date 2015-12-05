import Foundation

class Engine {

	let world = World()
	var state = GameState()

	var hero = Actor()

	init(level: Level) {
		setup(level)
	}

	func setup(level: Level) {

		level.forEach { node in
			let platform = node.platform
			world.createStaticBody(platform.position.asVector(), size: platform.size.asVector())
		}

		hero.body = world.createDynamicBody(Vector(dx: 300, dy: 100), size: Size(width: 1, height: 2).asVector())
	}

	func handleInput(input: Input) {
		let dPad = input.dPad.rawValue
		if dPad & DSHatDirection.Left.rawValue != 0 {
//			state.hero.position.dx -= 1
		}
		if dPad & DSHatDirection.Right.rawValue != 0 {
//			state.hero.position.dx += 1
		}
		if dPad & DSHatDirection.Up.rawValue != 0 {
//			state.hero.position.dy += 1
		}
		if dPad & DSHatDirection.Down.rawValue != 0 {
//			state.hero.position.dy -= 1
		}
	}

	func simulatePhysics(input: Input) -> GameState {
		handleInput(input)

		world.step()

		state.hero.position = hero.body!.position

		return state
	}
}
