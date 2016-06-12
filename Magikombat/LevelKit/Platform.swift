import Foundation

struct Platform {
	var position: Position
	var size: Size
	var type: Tile = .Wall

	func forEach(@noescape f: Position -> ()) {
		for x in position.x ..< (position.x + size.width) {
			for y  in position.y ..< (position.y + size.height) {
				f(Position(x: x, y: y))
			}
		}
	}
}

final class PlatformNode: Equatable {

	let platform: Platform

	init(_ platform: Platform) {
		self.platform = platform
	}

	var left: PlatformNode? = nil {
		didSet {
			if left?.right != self { left?.right = self }
		}
	}
	var right: PlatformNode? = nil{
		didSet {
			if right?.left != self { right?.left = self }
		}
	}
	var top: PlatformNode? = nil{
		didSet {
			if top?.bottom != self { top?.bottom = self }
		}
	}
	var bottom: PlatformNode? = nil{
		didSet {
			if bottom?.top != self { bottom?.top = self}
		}
	}

	var linkedNodes: [PlatformNode] {
		return [left, right, top, bottom].flatMap { $0 }
	}
}

func ==(lhs: PlatformNode, rhs: PlatformNode) -> Bool {
	return lhs === rhs
}
