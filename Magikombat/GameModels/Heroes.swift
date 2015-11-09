import Foundation

/// Crit hits
class BladeMaster: Hero {
	var stats: HeroStats {
		let baseStats = BaseStats(str: 14, dex: 13, int: 4, vit: 13)
		return HeroStats(stats: baseStats)
	}
}

/// Fast weak attacks, evasion
class DemonHunter: Hero {
	var stats: HeroStats {
		let baseStats = BaseStats(str: 12, dex: 14, int: 8, vit: 12)
		return HeroStats(stats: baseStats)
	}
}

/// Tough hero, with splash skill like Thunder Clap
class MountainKing: Hero {
	var stats: HeroStats {
		let baseStats = BaseStats(str: 16, dex: 8, int: 4, vit: 14)
		return HeroStats(stats: baseStats)
	}
}

/// Ranged hero, throws fireballs
/// AoE dmg Dragon Slave alike
class Lina: Hero {
	var stats: HeroStats {
		let baseStats = BaseStats(str: 8, dex: 6, int: 18, vit: 10)
		return HeroStats(stats: baseStats)
	}
}
