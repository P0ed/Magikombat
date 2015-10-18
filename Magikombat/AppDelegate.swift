import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!

	let eventsController = EventsController()
	var eventMonitors = [UInt: AnyObject]()

	var navigationController: NavigationController?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
		/* Sprite Kit applies additional optimizations to improve rendering performance */
		skView!.ignoresSiblingOrder = true

		skView!.showsFPS = true
		skView!.showsNodeCount = true

		navigationController = NavigationController(view: skView!)
		navigationController!.showMainMenu()

		setupDeviceObservers()
    }

    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
		return true
    }

	func setupDeviceObservers() {
		let deviceManager = OEDeviceManager.sharedDeviceManager()
		let notificationCenter = NSNotificationCenter.defaultCenter()
		let didAddDeviceKey = OEDeviceManagerDidAddDeviceHandlerNotification
		let didRemoveDeviceKey = OEDeviceManagerDidRemoveDeviceHandlerNotification

		notificationCenter.addObserverForName(didAddDeviceKey, object: nil, queue: NSOperationQueue.mainQueue()) { note in
			let deviceHandler = note.userInfo![OEDeviceManagerDeviceHandlerUserInfoKey] as! OEDeviceHandler
			self.eventMonitors[deviceHandler.deviceIdentifier] = deviceManager.addEventMonitorForDeviceHandler(deviceHandler) {
				handler, event in
				self.eventsController.handleEvent(event)
			}
		}

		notificationCenter.addObserverForName(didRemoveDeviceKey, object: nil, queue: NSOperationQueue.mainQueue()) { note in
			let deviceHandler = note.userInfo![OEDeviceManagerDeviceHandlerUserInfoKey] as! OEDeviceHandler
			self.eventMonitors.removeValueForKey(deviceHandler.deviceIdentifier)
		}
	}
}

func appDelegate() -> AppDelegate {
	return NSApplication.sharedApplication().delegate as! AppDelegate
}

func navigationController() -> NavigationController {
	return appDelegate().navigationController!
}
