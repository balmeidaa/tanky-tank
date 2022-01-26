extends StaticBody2D

const bullet_speed := 1200
export var speed := 400  # How fast the player will move (pixels/sec).
var speed_rotation := 5.0
var screen_size  # Size of the game window.
onready  var turret := $Turret
onready var dust_trail := $DustTrail
const Bullet = preload("res://Bullet.tscn")
var is_reloading := false

# Called when the node enters the scene tree for the first time.
func _ready():
    screen_size = get_viewport_rect().size
    
    


func _process(delta):
    var velocity = Vector2()  # The player's movement vector.
    var new_particle_direction = dust_trail.process_material.get("direction")
    var turret_angle = turret.get_rotation_degrees()
    
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
        new_particle_direction = -new_particle_direction
    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
        new_particle_direction = -new_particle_direction
    if Input.is_action_pressed("ui_down"):
        turret_angle += speed_rotation
    if Input.is_action_pressed("ui_up"):
        turret_angle -= speed_rotation
        
    if Input.is_action_pressed("ui_accept"):
        if not is_reloading:
            is_reloading = true
            shoot()
    
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        dust_trail.process_material.set("direction", new_particle_direction )
        
    if turret.get_rotation_degrees() != turret_angle:
        turret_angle = clamp(turret_angle, -180, 0)
        turret.set_rotation_degrees(turret_angle)

    position += velocity * delta
    position.x = clamp(position.x, 50, screen_size.x-60)

    
func shoot():
    $Reload.start()
    $Shoot.play()
    var muzzle = turret.get_node("Position2D") 
    var bullet = Bullet.instance()
    owner.add_child(bullet)
    bullet.transform = muzzle.global_transform
    bullet.apply_central_impulse(bullet.transform.x * bullet_speed)
 



func _on_Reload_timeout():
    is_reloading = false
