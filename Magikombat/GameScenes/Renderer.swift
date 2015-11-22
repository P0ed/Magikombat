import Foundation
import SpriteKit

let tileSize = 32

func createHero() -> SKNode {
	let color = SKColor(red: 0.9, green:0.2, blue: 0.3, alpha: 1.0)
	let size = CGSize(width: tileSize, height: tileSize)
	return SKSpriteNode(color: color, size: size)
}

final class Renderer {
	let world: SKNode
	let level: Level
	let camera: SKNode

	var hero: SKNode

	init(level: Level, world: SKNode, camera: SKNode) {
		self.level = level
		self.world = world
		self.camera = camera

		hero = createHero()

		drawLevel()
		drawHero()
	}

	private func drawHero() {
		world.addChild(hero)
	}

	private func drawLevel() {
		level.forEach {
			let platform = $0.platform

			func tileColor(tile: Tile) -> SKColor {
				switch tile {
				case .Wall: return SKColor(red: 0.8, green: 0.7, blue: 0.3, alpha: 1.0)
				case .Platform: return SKColor(red: 0.4, green: 0.5, blue: 0.5, alpha: 1.0)
				}
			}

			let size = CGSize(width: platform.size.width * tileSize, height: platform.size.height * tileSize)
			let node = SKSpriteNode(color: tileColor(platform.type), size: size)
			node.position = CGPoint(x: platform.position.x * tileSize, y: platform.position.y * tileSize)
			node.anchorPoint = CGPointZero
			world.addChild(node)
		}
	}

	func renderState(state: GameState) {
		hero.position = CGPoint(state.hero.position)

		camera.position = hero.position
	}
}

extension CGPoint {
	init(_ vector: Vector) {
		x = CGFloat(vector.dx)
		y = CGFloat(vector.dy)
	}
}
