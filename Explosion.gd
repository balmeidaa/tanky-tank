extends Node2D

onready var explosion1 = preload("res://sfx/Explosion2.wav")
onready var explosion2 = preload("res://sfx/bomb.wav")
    
var sound_list: Array

func _ready():
    randomize() 
    sound_list = [ explosion1, explosion2 ] 
    var sound_index = randi() % 2
    $AudioStream.stream = sound_list[sound_index]  
  


