extends Node2D

@onready var label: Label = $Label

@onready var progress_bar: ProgressBar = $"timer A"

@onready var gameoverlabel: Label = $gameover
@onready var timer_b: ProgressBar = $"timer B"


const gridsize = 20
const g_hieght = 30
const g_width = 30



var timerAmax_base = 5.0
var timerAmax = timerAmax_base

var timerA = 0
var difficultyinc = 0.1
var timerbmin = 1.5
var food  := Vector2i(-1,-1)
var score : = 0

var mov_interwelbase =.12
var mov_interwelmin=0.12
var sppedinc = 0.003
var mov_interwel = mov_interwelbase
var snake :Array = []
var direc := Vector2i(1,0)
var nextdirec := Vector2i(1,0)
var timerAmax_min = 0
var gameover := false
var mov_timer = 0.0

func _ready() -> void:
	snake =[Vector2i(10,10), Vector2i(9,10) , Vector2i(8,10)]
	
	progress_bar.min_value = 0
	timer_b.max_value = timerbmin
	timer_b.min_value = 0
	
	gameoverlabel.text = ""
	foodspawn()

func _process(delta: float) -> void:
	if gameover :
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://mainmenu.tscn")
			
		return
	movement()
	
	mov_timer += delta
	
	if mov_timer >=mov_interwel:
		mov_timer=0.0
	
		step()
	timerA += delta
	progress_bar.value = timerAmax -timerA
	timer_b.value = min(timerA,timerbmin)
	if timerA>= timerAmax:
		snakeshrink()
		timerA = 0 
	
	
	queue_redraw()
	
	
	
	
	
	
	
func movement()-> void:
	if Input.is_action_just_pressed("ui_up") and direc != Vector2i(0,1):
		nextdirec= Vector2i(0,-1)
		
	if Input.is_action_just_pressed("ui_down") and direc != Vector2i(0,-1):
		nextdirec = Vector2i (0,1)
	if Input.is_action_just_pressed("ui_left") and direc != Vector2i(1,0):
		nextdirec = Vector2i(-1,0)
	if Input.is_action_just_pressed("ui_right") and direc!= Vector2i(-1,0):
		nextdirec = Vector2i(1,0)
		
		


func step() -> void:
	direc = nextdirec
	var newhead = snake[0]+ direc
	if newhead.x < 0 or newhead.x >= g_width or newhead.y <0 or newhead.y >= g_hieght:
		
		gameover=true
		gameoverlabel.text = "GAME OVER!!!!     Score%d\nPress Enter to Restart " %score
		return
	if newhead in snake :
		gameover=true
		gameoverlabel.text = "GAME OVER!!!!     Score%d\nPress Enter to Restart " %score
		return
		
	snake.insert(0,newhead)
	
	if newhead == food:
		if timerA <timerbmin:
			snakeshrink(false)
			label.text = "too fast"
		else:
			score = score +1
			label.text ="score : %d" % score
			difficultyupdate()
		foodspawn()
		timerA = 0
	else:
		
		snake.pop_back()



func _draw() -> void:
	var wallcol = Color(0.011, 0.021, 0.012, 1.0)
	if timerA > timerAmax-1:
		wallcol = Color(.9,.2,.2)
	draw_rect(Rect2(0,0,g_width*gridsize,g_hieght*gridsize),wallcol,false,10)
	draw_rect(Rect2(food.x*gridsize , food.y*gridsize ,gridsize-1 ,gridsize-1),Color(1.17, 0.329, 0.731, 1.0))
	for i in snake.size():
		var seg = snake[i]
		var color = Color(0.2,0.9,0.3) if i ==0 else Color(0.1,0.6,0.2)
		draw_rect(Rect2(seg.x*  gridsize , seg.y * gridsize ,gridsize-1,gridsize-1),color)
		
		
		
		

func foodspawn() -> void:
	var pos
	while true:
		pos = Vector2i(randi()% g_width , randi() % g_hieght)
		if pos not in snake:
			break
	food = pos
	
	
	
	
func snakeshrink(candie:bool = true) -> void:
	if candie:
		if snake.size() > 0:
			snake.pop_back()
		if snake.size()== 0:
			gameoverlabel.text = "GAME OVER\nScore%d\nPress Enter to Restart " %score
			gameover = true
	else:
		if snake.size() > 1:
			snake.pop_back()
			
			
func difficultyupdate() -> void:
	timerAmax = max(timerAmax_base-(score*difficultyinc),timerAmax_min)
	progress_bar.max_value = timerAmax
	mov_interwel=max(mov_interwelbase - (score*sppedinc),mov_interwelmin)
