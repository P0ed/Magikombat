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
	var state: GameState
	let level: Level

	var simulationTime: SimulationTime?
	var stateBuffer: [(tick: Int, state: GameState)] = []

	var accumulator = 0.0

	init(level: Level) {
		self.level = level
		engine = Engine()
		remote = RemoteEngineConnection()
		state = GameState()
	}

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
			state = engine.simulatePhysics(state, input: input)

			accumulator -= SimulationTime.dt
		}

		let alpha = accumulator / SimulationTime.dt

		return interpolate(s1: state, s2: state, alpha: alpha)
	}
}

func interpolate(s1 s1: GameState, s2: GameState, alpha: Double) -> GameState {
	return s1
}
