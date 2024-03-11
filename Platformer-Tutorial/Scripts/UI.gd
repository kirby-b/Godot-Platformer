extends CanvasLayer

#Onready for loading nodes
@onready var heart1 = $Heart1
@onready var heart2 = $Heart2
@onready var heart3 = $Heart3
@onready var big_digit = $UpperDigit
@onready var small_digit = $LowerDigit
@onready var coin_icon = $CoinIcon

#Variables to track coins and life
var coin_count_higher = 0
var coin_count_lower = 0
var life = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	coin_icon.play("spin") #Animates the coin on the hud
	#Connects to events so it can react to them
	Events.connect("coin_get", Callable(self, "_on_coin_get"))
	Events.connect("player_hurt", Callable(self , "_on_player_hurt"))
	Events.connect("respawn", Callable(self, "_on_respawn"))

#Runs on respawn to reset values for hearts and probably other stuff in the future
func _on_respawn():
	life = 6
	heart1.frame = 0
	heart2.frame = 0
	heart3.frame = 0
	
#Controls what happens when you get a coin
func _on_coin_get():
	coin_count_lower += 1
	if coin_count_lower >= 10:
		coin_count_lower -= 10
		coin_count_higher += 1
	if coin_count_higher >= 10:
		life += 1 #This is temporary. It will later be changed to a sort of 1 up
	small_digit.frame = coin_count_lower
	big_digit.frame = coin_count_higher
	
#Controls player hurting and life bar
func _on_player_hurt():
	life -= 1
	match life:
		6: 
			heart3.frame = 0
		5: 
			heart3.frame = 1
		4: 
			heart3.frame = 2
			heart2.frame = 0
		3:
			heart2.frame = 1
		2: 
			heart2.frame = 2
			heart1.frame = 0
		1: 
			heart1.frame = 1
		0: 
			heart1.frame = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
