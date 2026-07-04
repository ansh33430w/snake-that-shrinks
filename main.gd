extends Node2D



const gridsize = 20
const g_hieght = 30
const g_width = 30


var mov_interwel =.12
var snake :Array = []
var direc := Vector2i(1,0)
var nextdirec := Vector2i(1,0)

var gameover := false
var mov_timer = 0.0

func _ready() -> void:
	snake =[Vector2i(10,10), Vector2i(9,10) , Vector2i(8,10)]


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
	snake.pop_back()



func _draw() -> void:
	for i in snake.size():
		var seg = snake[i]
		var color = Color(0.2,0.9,0.3) if i ==0 else Color(0.1,0.6,0.2)
		draw_rect(Rect2(seg.x*  gridsize , seg.y * gridsize ,gridsize-1,gridsize-1),color)
