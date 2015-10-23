import Foundation
import SpriteKit
import BrightFutures

class MenuScene: SKScene {

	let model: MenuModel
	let promise: Promise<MenuResult, FlowError>

	var labels: [SKLabelNode] = []
	var selectedIndex: Int? {
		didSet {
			guard oldValue != selectedIndex else { return }
			guard let index = selectedIndex else { return }

			labels.enumerate().forEach {
				$0.element.fontColor = $0.index == index ? NSColor.redColor() : NSColor.blueColor()
			}
		}
	}

	lazy var deviceConfiguration: DeviceConfiguration = {
		DeviceConfiguration(
			buttonsMapTable: [
				.Cross: PressAction(self.pressItem),
				.Circle: PressAction(self.escape)
			],
			dPadMapTable: [
				.Up: PressAction(self.selectPreviousItem),
				.Down: PressAction(self.selectNextItem)
			],
			keyboardMapTable: [
				DeviceConfiguration.keyCodeForVirtualKey(kVK_UpArrow): PressAction(self.selectPreviousItem),
				DeviceConfiguration.keyCodeForVirtualKey(kVK_DownArrow): PressAction(self.selectNextItem),
				DeviceConfiguration.keyCodeForVirtualKey(kVK_Return): PressAction(self.pressItem),
				DeviceConfiguration.keyCodeForVirtualKey(kVK_Delete): PressAction(self.escape)
			]
		)
	}()

	init(size: CGSize, model: MenuModel) {
		self.model = model
		promise = Promise()

		super.init(size: size)

		scaleMode = .ResizeFill

		setupItems()
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}

	func resolve() -> Future<MenuResult, FlowError> {
		return promise.future
	}

	override func becomeFirstResponder() -> Bool {
		appDelegate().eventsController.deviceConfiguration = deviceConfiguration
		return true
	}

	override func didChangeSize(oldSize: CGSize) {
		super.didChangeSize(oldSize)
		layoutItems()
	}

	func setupItems() {
		switch model {
		case let .Plain(items):
			self.removeChildrenInArray(labels)

			labels = items.map {
				SKLabelNode(text: $0.title)
			}
			labels.forEach(self.addChild)

			selectedIndex = labels.count > 0 ? 0 : nil
		}
		layoutItems()
	}

	func layoutItems() {
		switch model {
		case .Plain(_):
			labels.reverse().enumerate().forEach {
				(index, node) in
				node.position = CGPoint(x: self.size.width / 2, y: 40 + CGFloat(index) * 40)
			}
		}
	}

	func selectNextItem() {
		switch selectedIndex {
		case .None where labels.count > 0: selectedIndex = 0
		case .Some(let index) where index < labels.count - 1: selectedIndex = index + 1
		case .Some(_): selectedIndex = 0
		default: break
		}
	}

	func selectPreviousItem() {
		switch selectedIndex {
		case .None where labels.count > 0: selectedIndex = 0
		case .Some(let index) where index > 0: selectedIndex = index - 1
		case .Some(_): selectedIndex = labels.count - 1
		default: break
		}
	}

	func pressItem() {
		switch model {
		case let .Plain(items):
			items[selectedIndex!].action().map(self.promise.success)
		}
	}

	func escape() {
		promise.failure(.Nothing)
	}

	/// FIXME: Убрать куда-нибудь (фиксит звук непохендленной клавиатуры)
	override func keyDown(theEvent: NSEvent) {

	}
}
