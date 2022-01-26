extends RigidBody2D



func _on_Timer_timeout():
    call_deferred("queue_free")


func _on_Area2D_body_entered(body):
    if is_in_group("Ground"):
        call_deferred("queue_free")

 
