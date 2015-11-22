import Foundation

struct Level {
	let rootNode: PlatformNode
	let size: Size

	init(rootNode: PlatformNode, size: Size) {
		self.rootNode = rootNode
		self.size = size
	}

	func forEach(@noescape f: (node: PlatformNode) -> ()) {
		
	}
}
