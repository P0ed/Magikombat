import Foundation

protocol Item {

	func applyToStats(stats: HeroStats)
}

protocol PassiveSkill {

	func applyToStats(stats: HeroStats)
}

struct BaseStats {
	var str: Int
	var dex: Int
	var int: Int
}

final class HeroStats {
	let startingStats: BaseStats

	var level: Int = 1

	lazy var stats: BaseStats = { self.startingStats }()

	/// Str based
	var maxHP: Int = 0
	var attackPower: Double = 0
	var armor: Double = 0
	var critDamage: Double = 0

	/// Dex based
	var speed: Double = 0
	var evasion: Double = 0
	var critChance: Double = 0

	/// Int based
	var techDamage: Double = 0
	var techArmor: Double = 0

	init(stats: BaseStats) {
		startingStats = stats
	}

	func updateStats(items: [Item], skills: [PassiveSkill]) {
		stats = startingStats
		items.forEach(applyItem)
	}

	func applyItem(item: Item) {
		return item.applyToStats(self)
	}
}

protocol Hero {
	var stats: HeroStats { get }

	
}
