import Foundation

final class PlatformNode {

	let platform: Platform

	init(platform: Platform) {
		self.platform = platform
	}

	var left: PlatformNode? = nil
	var right: PlatformNode? = nil
	var top: PlatformNode? = nil
	var bottom: PlatformNode? = nil
}

struct Platform {
	var position: Position
	var size: Size
	var type: Tile = .Wall
}
