extends Node
signal player_hit

func update_player_health():
    emit_signal("player_hit")
