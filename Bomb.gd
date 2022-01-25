extends RigidBody2D
const Explosion := preload("res://Explosion.tscn")
onready var explosion_position := $ExplosionPosition

func _on_Timer_timeout():
    queue_free()


func explode():
    var explosion = Explosion.instance()
    add_child(explosion)
    explosion.scale = Vector2(.3,.3)
    explosion.position = explosion_position.position
    $Sprite.hide()
    $Area2D/CollisionShape2D.queue_free()
    $Timer.start()


func _on_Area2D_body_entered(body):
    explode()
    if body.is_in_group("Player"):
        PlayerEventHandler.update_player_health()
