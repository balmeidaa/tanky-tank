extends Node2D

const Tank = preload("res://Tank.tscn")
const Bomber = preload("res://Bomber.tscn")
const Kamikaze = preload("res://Kamikaze.tscn")

onready var credits_container := $Menu/Credits
onready var life_label := $Margin/Container/containerHP/life
onready var score_label := $Margin/Container/containerScore/score
onready var score_timer := $ScoreTimer
onready var camera := $Camera2D
onready var paralax := $ParallaxBackground
var scroll_speed := 1.2

var score := 0
var life_points := 3
var rng = RandomNumberGenerator.new()

func stop():
    score_timer.stop()
    $Player.hide()  
    $ScoreTimer.stop()
    $BomberTimer.stop()
    $KamikazeTimer.stop()
    $TankTimer.stop()
    $Menu.show()
    get_tree().call_group("Tank", "queue_free")

func start():
    score = 0
    life_points = 3
    
    $Player.position = $StartPoint.position
    $Player.show()
    score_label.text = String(score)
    life_label.text = String(life_points)
    $ScoreTimer.start()
    $TankTimer.start()
    $BomberTimer.start()
    $KamikazeTimer.start()
  
    
func _ready():
    credits_container.hide()
    randomize()
    rng.randomize()
    PlayerEventHandler.connect("player_hit", self, "update_player_hit_points")
    stop()

func _process(_delta):
    if life_points <= 0:
        $Menu/MenuContainer/Label.text = "Time Survived: " + String(score)
        stop()
    paralax.offset.x-=scroll_speed
    if paralax.offset.x <= -1024:
        paralax.offset.x = 0


func _on_BomberTimer_timeout():
    $BomberPath/spawn.offset = randi()
    var direction_list := [0 , PI]
    var direction = direction_list[randi() % direction_list.size()]
    var bomber = Bomber.instance()
    add_child(bomber)
    bomber.scale = Vector2(0.2, 0.2)
    bomber.position =  $BomberPath/spawn.position
    bomber.position.y = rand_range(50, 200)
    if direction > 0: 
        bomber.position.x = 1024
        bomber.get_node("Sprite").scale.x =  bomber.get_node("Sprite").scale.x * -1 
    else:
         bomber.position.x = -30
        
    bomber.linear_velocity = Vector2(rand_range(bomber.min_speed, bomber.max_speed), 0)
    bomber.linear_velocity = bomber.linear_velocity.rotated(direction)


func _on_KamikazeTimer_timeout():
    var offset_y = -20
    var initial_x = rand_range(50, 1200)
    var kamikaze = Kamikaze.instance()
    add_child(kamikaze)
    kamikaze.scale = Vector2(0.2, 0.2)
    kamikaze.position = Vector2(initial_x, offset_y)
    kamikaze.linear_velocity = Vector2(rand_range(kamikaze.min_speed, kamikaze.max_speed), 0)
    var angle = $Player.position - kamikaze.position
    var direction := atan2(angle.y, angle.x)
    kamikaze.rotation = direction
    kamikaze.linear_velocity = kamikaze.linear_velocity.rotated(direction)


func update_player_hit_points():
    if life_points > 0:
        life_points -= 1
        life_label.text = String(life_points)
    


func _on_ScoreTimer_timeout():
    score += 1
    score_label.text = "Score: " + String(score)


func _on_Start_pressed():
    $Menu.hide()
    start()
    


func _on_Credits_pressed():
    $Menu/MenuContainer.hide()
    credits_container.show()


func _on_Back_pressed():
    credits_container.hide()
    $Menu/MenuContainer.show()


func _on_TankTimer_timeout():
    var offset_x = 1040
    var initial_y = 572
    var tank = Tank.instance()
    add_child(tank)
    tank.scale = Vector2(0.1, 0.1)
    tank.position = Vector2(offset_x, initial_y)
    tank.linear_velocity = Vector2(rand_range(tank.min_speed, tank.max_speed), 0)
 

