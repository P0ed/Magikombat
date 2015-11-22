import Foundation

struct Level {
	let rootNode: PlatformNode
	let size: Size

	init(rootNode: PlatformNode, size: Size) {
		self.rootNode = rootNode
		self.size = size
	}

	var allNodes: [PlatformNode] {
		var nodes = [PlatformNode]()
		forEach { nodes.append($0) }
		return nodes
	}

	func forEach(@noescape f: PlatformNode -> ()) {
		var visited = [PlatformNode]()
		var toVisit = [rootNode]

		func visitNode(node: PlatformNode, inout _ toVisit: [PlatformNode], @noescape _ f: PlatformNode -> ()) {
			f(node)
			visited.append(node)

			let unvisited = node.linkedNodes.filter { !visited.contains($0) }
			toVisit.appendContentsOf(unvisited)
		}

		while (toVisit.count > 0) {
			visitNode(toVisit.removeFirst(), &toVisit, f)
		}
	}
}
