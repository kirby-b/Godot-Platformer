extends CanvasLayer

# Onready for loading nodes
@onready var heart1 = $Heart1
@onready var heart2 = $Heart2
@onready var heart3 = $Heart3
@onready var big_digit = $UpperDigit
@onready var small_digit = $LowerDigit
@onready var coin_icon = $CoinIcon

# Variables to track life
var life = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	coin_icon.play("spin") # Animates the coin on the hud
	# Connects to events so it can react to them
	Events.connect("coin_get", Callable(self, "_on_coin_get"))
	Events.connect("diamond_get", Callable(self, "_on_diamond_get"))
	Events.connect("player_hurt", Callable(self , "_on_player_hurt"))
	Events.connect("respawn", Callable(self, "_on_respawn"))

# Runs on respawn to reset values for hearts and probably other stuff in the future
func _on_respawn():
	life = 6
	heart1.frame = 0
	heart2.frame = 0
	heart3.frame = 0
	
# Controls what happens when you get a coin
func _on_coin_get():
	GlobalVars.coins_lower += 1
	if GlobalVars.coins_lower >= 10:
		GlobalVars.coins_lower -= 10
		GlobalVars.coins_upper += 1
	if GlobalVars.coins_upper >= 10:
		GlobalVars.coins_upper -= 10
		# This will become a one up call later

func _on_diamond_get():
	GlobalVars.coins_lower += 5
	if GlobalVars.coins_lower >= 10:
		GlobalVars.coins_lower -= 10
		GlobalVars.coins_upper += 1
	if GlobalVars.coins_upper >= 10:
		GlobalVars.coins_upper -= 10
		# This will become a one up call later
	
# Controls player hurting
func _on_player_hurt():
	life -= 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Sets coin frames to coin counts
	small_digit.frame = GlobalVars.coins_lower
	big_digit.frame = GlobalVars.coins_upper
	# Matchs the life count. Its better than a bunch of if statments.....
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
