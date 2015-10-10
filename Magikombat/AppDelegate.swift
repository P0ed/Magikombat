import Cocoa
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameLevelScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!

	var eventsController = EventsController()
	var eventMonitors = [UInt: AnyObject]()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        /* Pick a size for the scene */
        if let scene = GameLevelScene.unarchiveFromFile("GameScene") as? GameLevelScene {
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            self.skView!.presentScene(scene)
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            self.skView!.ignoresSiblingOrder = true
            
            self.skView!.showsFPS = true
            self.skView!.showsNodeCount = true
        }

		setupDeviceObservers()
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }

	func setupDeviceObservers() {
		OEDeviceManager.sharedDeviceManager()
		let notificationCenter = NSNotificationCenter.defaultCenter()
		let didAddDeviceKey = OEDeviceManagerDidAddDeviceHandlerNotification
		let didRemoveDeviceKey = OEDeviceManagerDidRemoveDeviceHandlerNotification

		notificationCenter.addObserverForName(didAddDeviceKey, object: nil, queue: NSOperationQueue.mainQueue()) { note in
			let deviceHandler = note.userInfo![OEDeviceManagerDeviceHandlerUserInfoKey] as! OEDeviceHandler
			self.eventMonitors[deviceHandler.deviceIdentifier] = OEDeviceManager.sharedDeviceManager().addEventMonitorForDeviceHandler(deviceHandler) {
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

