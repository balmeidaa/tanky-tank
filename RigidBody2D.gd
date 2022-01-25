extends RigidBody2D



func _on_VisibilityNotifier2D_viewport_exited(viewport):
    hide()


func _on_VisibilityNotifier2D_viewport_entered(viewport):
    show()
    
