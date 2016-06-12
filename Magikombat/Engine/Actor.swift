import Foundation

class Actor {

	var body: Body?

	let maxSpeed: Float = 1.2

	func handleInput(input: Input) {
		let dPad = input.dPad.rawValue
		var v = Vector.zeroVector

		if dPad & DSHatDirection.Left.rawValue != 0 {
			let velocity = body!.velocity.dx
			v.dx = body!.mass * (max(velocity - 0.02, -maxSpeed) - velocity)
		}
		if dPad & DSHatDirection.Right.rawValue != 0 {
			let velocity = body!.velocity.dx
			v.dx = body!.mass * (min(velocity + 0.02, maxSpeed) - velocity)
		}
		if dPad & DSHatDirection.Up.rawValue != 0 {
			v.dy = 0.08
		}
		if dPad & DSHatDirection.Down.rawValue != 0 {

		}

		body?.applyImpulse(v)
	}
}
