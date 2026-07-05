extends Node2D

@onready var label: Label = $Label


const gridsize = 20
const g_hieght = 30
const g_width = 30


var food  := Vector2i(-1,-1)
var score : = 0

var mov_interwel =.12
var snake :Array = []
var direc := Vector2i(1,0)
var nextdirec := Vector2i(1,0)

var gameover := false
var mov_timer = 0.0

func _ready() -> void:
	snake =[Vector2i(10,10), Vector2i(9,10) , Vector2i(8,10)]
	foodspawn()

func _process(delta: float) -> void:
	if gameover :
		return
	movement()
	mov_timer += delta
	if mov_timer >=mov_interwel:
		mov_timer=0.0
		step()
	
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
		return
	if newhead in snake :
		gameover=true
		return
		
	snake.insert(0,newhead)
	
	if newhead == food:
		score = score +1
		label.text ="score : %d" % score
		
		foodspawn()
		
	else:
		
		snake.pop_back()



func _draw() -> void:
	draw_rect(Rect2(0,0,g_width*gridsize,g_hieght*gridsize),Color(0.8,0.8,0.8),false,2.0)
	draw_rect(Rect2(food.x*gridsize , food.y*gridsize ,gridsize-1 ,gridsize-1),Color(0.9,0.9,0.9))
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
	
	
