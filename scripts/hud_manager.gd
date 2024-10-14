extends Control
@onready var coins_counter = $container/coins_container/coins_counter as Label
@onready var timer_counter = $container/timer_container/timer_counter as Label
@onready var life_counter = $container/life_container/life_counter as Label
@onready var score_counter = $container/score_container/score_counter as Label
@onready var clock_timer = $clock_timer as Timer
var minutes = 0
var seconds = 0
@export_range(0, 5) var default_minutes := 1
@export_range(0, 59) var defalt_seconds := 0
# Chamada automaticamente quando o nó entra na árvore
func _ready():
	coins_counter.text = str("%04d" % globals.coins)
	score_counter.text = str("%06d" % globals.score)
	life_counter.text = str("%02d" % globals.player_life)
	timer_counter.text = str("%02d" % default_minutes) + ":" +  str("%02d" % defalt_seconds)
# Chamado a cada frame
func _process(delta):
	coins_counter.text = str("%04d" % globals.coins)
	score_counter.text = str("%06d" % globals.score)
	life_counter.text = str("%02d" % globals.player_life)
	timer_counter.text = str("%02d" % default_minutes) + ":" +  str("%02d" % defalt_seconds)
