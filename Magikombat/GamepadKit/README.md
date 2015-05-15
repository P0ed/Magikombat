USAGE:
======

```swift
let jumpAction = DeviceAction<Bool>() { pressed in
	if pressed {
		self.hero.jump()
	}
}

let deviceConfiguration = DeviceConfiguration()
deviceConfiguration.buttonsMapTable = [DSButton.Cross: jumpAction]

```
