import SpriteKit
import Carbon.HIToolbox.Events


class GameLevelScene: SKScene {

	let spriteSize = 32

    override func didMoveToView(view: SKView) {

		self.becomeFirstResponder()

		let moveAction = DeviceAction<Bool>() { pressed in
			if pressed {

			}
		}

		appDelegate().eventsController.deviceConfiguration.buttonsMapTable = [DSButton.Cross: moveAction]
		appDelegate().eventsController.deviceConfiguration.keyboardMapTable = [
			Int(OEHIDEvent.keyCodeForVirtualKey(CGCharCode(kVK_ANSI_A))): moveAction,
			Int(OEHIDEvent.keyCodeForVirtualKey(CGCharCode(kVK_ANSI_D))): moveAction
		]

		let tileMap = TileMapGenerator.generateTileMap()
		let gameLevel = GameLevel(tileMap: tileMap)
		self.loadGameLevel(gameLevel)
    }
    
    override func update(currentTime: CFTimeInterval) {
//		let vector = appDelegate().eventsController.rightJoystick
//		model!.position.x += CGFloat(vector.dx * 10)
//		model!.position.y += CGFloat(vector.dy * 10)
    }

	func loadGameLevel(gameLevel: GameLevel) {

		var row = 0
		for tilesRow in gameLevel.tileMap.tiles {
			var column = 0
			for tile in tilesRow {

				if tile.type == .Dirt {
					let sprite = SKSpriteNode(imageNamed: "Dirt")
					sprite.size = CGSize(width: spriteSize, height: spriteSize)
					sprite.position = CGPoint(x: column * spriteSize + spriteSize / 2, y: row * spriteSize + spriteSize / 2)
					self.addChild(sprite)
				}
				++column
			}
			++row
		}
	}
}
