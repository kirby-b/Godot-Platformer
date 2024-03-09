extends CanvasLayer

@onready var heart1 = $Heart1
@onready var heart2 = $Heart2
@onready var heart3 = $Heart3
@onready var big_digit = $UpperDigit
@onready var small_digit = $LowerDigit
@onready var coin_icon = $CoinIcon

var player_script = preload("res://Scripts/player.gd").new()

var coin_count = 0
var life = 6


# Called when the node enters the scene tree for the first time.
func _ready():
	coin_icon.play("spin")
	Events.connect("coin_get", Callable(self, "_on_coin_get"))
	Events.connect("player_hurt", Callable(self , "_on_player_hurt"))
	
func _on_coin_get():
	pass
	
func _on_player_hurt():
	life -=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
