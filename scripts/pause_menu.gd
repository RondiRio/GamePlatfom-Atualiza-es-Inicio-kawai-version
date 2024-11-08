extends CanvasLayer

@onready var resume_btn = $menu_holder/resume_btn
@onready var restart: Button = $menu_holder/restart

func _ready():
	visible = false

func _process(delta):
	pass

# Função para reiniciar o jogo
func restart_game():
	# Verifique se `reload_game` existe em um nó principal ou global
	if has_node("/root/Main") and get_node("/root/Main").has_method("reload_game"):
		get_node("/root/Main").reload_game()
	else:
		print("Erro: reload_game não encontrado no nó principal.")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true
		resume_btn.grab_focus()

func _on_resume_btn_pressed():
	get_tree().paused = false
	visible = false
	
func _on_quit_btn_pressed():
	get_tree().quit()
