extends CanvasLayer

# Onready for loading nodes
@onready var heart1 = $Heart1
@onready var heart2 = $Heart2
@onready var heart3 = $Heart3
@onready var big_digit = $UpperDigit
@onready var small_digit = $LowerDigit
@onready var big_lives = $UpperLife
@onready var small_lives = $LowerLife
@onready var upper_ammo = $BulletSprite/UpperAmmo
@onready var lower_ammo = $BulletSprite/LowerAmmo
@onready var coin_icon = $CoinIcon

# Variables to track life
var life = 6
var lives_str = ""
var ammo_str = ""

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
		if GlobalVars.lives < 99:
			SoundPlayer.play_sound(SoundPlayer.ONEUP)
			GlobalVars.lives += 1

func _on_diamond_get():
	GlobalVars.coins_lower += 5
	if GlobalVars.coins_lower >= 10:
		GlobalVars.coins_lower -= 10
		GlobalVars.coins_upper += 1
	if GlobalVars.coins_upper >= 10:
		GlobalVars.coins_upper -= 10
		if GlobalVars.lives < 99:
			SoundPlayer.play_sound(SoundPlayer.ONEUP)
			GlobalVars.lives += 1
	
# Controls player hurting
func _on_player_hurt():
	life -= 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Controls lives display
	lives_str = str(GlobalVars.lives) # String to get indexes
	if GlobalVars.lives >= 10: # For lives over 10
		small_lives.frame = int(lives_str[1])
		big_lives.frame = int(lives_str[0])
	else: # For lives under 10
		small_lives.frame = int(lives_str[0])
		big_lives.frame = 0 
	if GlobalVars.has_gun:
		# Controls ammo display
		$BulletSprite.visible = true
		ammo_str = str(GlobalVars.ammo) # String to get indexes
		if GlobalVars.ammo >= 10: # For ammo over 10
			lower_ammo.frame = int(ammo_str[1])
			upper_ammo.frame = int(ammo_str[0])
		else: # For ammo under 10
			lower_ammo.frame = int(ammo_str[0])
			upper_ammo.frame = 0
	else:
		$BulletSprite.visible = false
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
