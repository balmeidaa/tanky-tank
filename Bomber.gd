extends "res://Bomb.gd"

const Bomb = preload("res://Bomb.tscn")
onready var dropPoint := $DropPoint
export var min_speed = 250  # Minimum speed range.
export var max_speed = 350  # Maximum speed range.



func _on_VisibilityNotifier2D_viewport_exited(_viewport):
    queue_free()


func drop_bomb():
    var bomb = Bomb.instance()
    add_child(bomb)
    bomb.position = dropPoint.position
    if linear_velocity.x < 0:
        bomb.get_node("Sprite").scale.y = -bomb.get_node("Sprite").scale.y  
        var ang_velocity = -bomb.get_angular_velocity()
        bomb.set_angular_velocity(ang_velocity)


func _on_RadarCollision_body_entered(body):
     if body.is_in_group("Player"):
         call_deferred("drop_bomb")


func _on_Area2D_body_entered(body):
    explode()
