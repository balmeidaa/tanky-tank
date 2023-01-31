extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():

    rng.randomize()
    var pitch = rng.randf_range(0.8, 2.0)
    $AudioStream.pitch_scale = pitch
  


