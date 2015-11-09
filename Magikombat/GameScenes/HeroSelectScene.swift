import Foundation
import SpriteKit

class HeroSelectScene: BaseScene {

	var heroesList: [Hero] = []
	var selectedHeroIndex: Int?

	override func didMoveToView(view: SKView) {
		super.didMoveToView(view);


	}

	override func controlsMap() -> DeviceConfiguration {
		return DeviceConfiguration(
			buttonsMapTable: [
				.Circle: PressAction { self.promise!.failure(.Nothing) }
			],
			dPadMapTable: [:],
			keyboardMapTable: [
				DeviceConfiguration.keyCodeForVirtualKey(kVK_Delete): PressAction {
					self.promise!.failure(.Nothing)
				}
			]
		)
	}
}
