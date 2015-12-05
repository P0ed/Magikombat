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
		hero.handleInput(input)
	}

	func simulatePhysics(input: Input) -> GameState {
		handleInput(input)

		world.step()

		state.hero.position = hero.body!.position

		return state
	}
}
