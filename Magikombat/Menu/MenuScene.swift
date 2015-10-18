import Foundation
import SpriteKit

class MenuScene: SKScene {

	let model: MenuModel
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

	var deviceConfiguration = DeviceConfiguration()

	init(size: CGSize, model: MenuModel) {
		self.model = model

		super.init(size: size)

		setupDeviceConfiguration()
		setupItems()
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}

	override func becomeFirstResponder() -> Bool {
		appDelegate().eventsController.deviceConfiguration = deviceConfiguration
		return true
	}

	override func didChangeSize(oldSize: CGSize) {
		super.didChangeSize(oldSize)
		layoutItems()
	}

	func setupDeviceConfiguration() {
		deviceConfiguration.dPadAction = DeviceAction {
			[unowned self] hatDirection in

			switch hatDirection {
			case .North: self.selectPreviousItem()
			case .South: self.selectNextItem()
			default: break
			}
		}
		deviceConfiguration.keyboardMapTable = [
			DeviceConfiguration.keyCodeForVirtualKey(kVK_UpArrow): DeviceAction {
				[unowned self] pressed in
				if pressed { self.selectPreviousItem() }
			},
			DeviceConfiguration.keyCodeForVirtualKey(kVK_DownArrow): DeviceAction {
				[unowned self] pressed in
				if pressed { self.selectNextItem() }
			}
		]
	}

	func setupItems() {
		switch model {
		case let .Plain(items):
			self.removeChildrenInArray(labels)

			labels = items.map {
				return SKLabelNode(text: $0.title)
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
			let item = items[selectedIndex!]
			item.action()
		}
	}

	func escape() {

	}

	/// FIXME: Убрать куда-нибудь (фиксит звук непохендленной клавиатуры)
	override func keyDown(theEvent: NSEvent) {

	}
}
