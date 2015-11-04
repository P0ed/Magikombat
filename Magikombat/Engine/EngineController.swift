import Foundation

struct SimulationTime {
	let startingTime: Double
	var currentTick: Int

	static let dt = 1.0 / 60.0

	func currentTime() -> Double {
		return startingTime + Double(currentTick) * SimulationTime.dt
	}
}

class EngineController {

	let engine: Engine
	let remote: RemoteEngineConnection

	init() {
		engine = Engine()
		remote = RemoteEngineConnection()
	}

	var simulationTime: SimulationTime?
	var stateBuffer: [(tick: Int, state: GameState)] = []

	var accumulator = 0.0


	func startGame(time: Double) {
		simulationTime = SimulationTime(startingTime: time, currentTick: 0)
	}

	func stateFromTime(time: Double, input: Input) -> GameState {

		remote.sendInput(input)

		if simulationTime == nil {
			startGame(time)
		}

		let frameTime = min(time - simulationTime!.currentTime(), 0.25)

		accumulator += frameTime

		while accumulator >= SimulationTime.dt {
			let state = engine.simulatePhysics(GameState(), input: input)

			accumulator -= SimulationTime.dt
		}

		let alpha = accumulator / SimulationTime.dt

		return interpolate(GameState(), alpha: alpha)
	}

	func interpolate(state: GameState, alpha: Double) -> GameState {
		return GameState()
	}
}
