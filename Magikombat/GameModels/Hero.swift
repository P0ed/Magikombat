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
	var vit: Int
}

class HeroStats {
	let startingStats: BaseStats

	var level: Int = 1

	lazy var stats: BaseStats = { self.startingStats }()

	var maxHP: Int = 0
	var maxEnergy: Int = 0

	var armor: Double = 0
	var evasion: Double = 0
	var critChance: Double = 0
	var critDamage: Double = 0

	init(stats: BaseStats) {
		startingStats = stats
	}

	func updateStats(items: [Item], skills: [PassiveSkill]) {

		stats = startingStats

		items.forEach {
			$0.applyToStats(self)
		}
	}
}

protocol Hero {
	var stats: HeroStats { get }

	
}
