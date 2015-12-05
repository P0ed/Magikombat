import Foundation

final class World {

	let worldRef: WorldRef

	init() {
		worldRef = B2DCreateWorld()
	}

	deinit {
		B2DReleaseWorld(worldRef)
	}

	func step() {
		B2DStep(worldRef)
	}

	func createStaticBody(position: Vector, size: Vector) -> Body {
		let bodyRef = B2DCreateStaticBody(worldRef, position.asB2DVector(), size.asB2DVector())
		let body = Body(bodyRef: bodyRef, type: .Static)
		return body
	}

	func createDynamicBody(position: Vector, size: Vector) -> Body {
		let bodyRef = B2DCreateDynamicBody(worldRef, position.asB2DVector(), size.asB2DVector())
		let body = Body(bodyRef: bodyRef, type: .Dynamic)
		return body
	}
}
