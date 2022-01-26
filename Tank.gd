extends "res://Bomb.gd"

export var min_speed = -400  # Minimum speed range.
export var max_speed = -550  # Maximum speed range.

func _ready():
    var new_particle_direction = $DustTrail.process_material.get("direction")
    $DustTrail.process_material.set("direction", -new_particle_direction )


func _on_Area2D_body_entered(body):

    if body.is_in_group("Player"):
        $Crash.play()
        PlayerEventHandler.update_player_health()

    $TrackLoop.stop()
    explode()
