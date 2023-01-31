extends RigidBody2D

func _on_Timer_timeout():
    $Ricochet.stop()
    call_deferred("queue_free")


func _on_Area2D_body_entered(body):
    $Ricochet.play()
    if is_in_group("Ground"):
        call_deferred("queue_free")

 
