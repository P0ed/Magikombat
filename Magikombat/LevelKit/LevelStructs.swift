import Foundation

struct Position {
	var x: Int
	var y: Int

	func asVector() -> Vector {
		return Vector(dx: Float(x), dy: Float(y))
	}
}

struct Size {
	var width: Int
	var height: Int

	func asVector() -> Vector {
		return Vector(dx: Float(width), dy: Float(height))
	}
}
