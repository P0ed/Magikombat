import SpriteKit

class Model {

	var positionSink: SinkOf<CGPoint>?
	var position = CGPoint() {
		didSet {
			if let positionSink = self.positionSink {
				positionSink.put(self.position)
			}
		}
	}

	func move() {
		position.x += 100
	}
}

class SpaceshipNode: SKSpriteNode {
	let model = Model()

	func positionSink() -> SinkOf<CGPoint> {
		return SinkOf() { [unowned self] newPosition in
			self.position = newPosition
		}
	}
	deinit {
		model.positionSink = nil
	}
}

class GameScene: SKScene {

	var model: Model?

    override func didMoveToView(view: SKView) {

		let sprite = SpaceshipNode(imageNamed:"Spaceship")
		model = sprite.model

		sprite.setScale(0.2)
		model!.positionSink = sprite.positionSink()
		self.addChild(sprite)

		model!.position = CGPoint(x: self.size.width / 2.0, y: self.size.height / 2.0)

		let moveAction = DeviceAction<Bool>() { pressed in
			if pressed {
				self.model!.move()
			}
		}

		appDelegate().eventsController.deviceConfiguration.buttonsMapTable = [DSButton.Cross: moveAction]
    }
    
    override func update(currentTime: CFTimeInterval) {
		let vector = appDelegate().eventsController.rightJoystick
		model!.position.x += CGFloat(vector.dx * 10)
		model!.position.y += CGFloat(vector.dy * 10)
    }
}
