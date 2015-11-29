import Foundation

struct Position {
	var x: Int
	var y: Int

	func asVector() -> Vector {
		return Vector(dx: Float(x * tileSize), dy: Float(y * tileSize))
	}
}

struct Size {
	var width: Int
	var height: Int

	func asVector() -> Vector {
		return Vector(dx: Float(width * tileSize), dy: Float(height * tileSize))
	}
}
