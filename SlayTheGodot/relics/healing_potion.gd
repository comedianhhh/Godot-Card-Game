extends Relic

@export var healing_amount: int = 6

func activate_relic(owner: RelicUI) -> void:
	var player := owner.get_tree().get_first_node_in_group("player") as Player
	if player:
		player.stats.heal(healing_amount)
		owner.flash()
