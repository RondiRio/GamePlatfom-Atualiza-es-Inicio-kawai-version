extends Node2D

@onready var texture = $texture
@onready var area_sign = $area_sign
#set_process_input(true)
const lines : Array[String] = [
	"Seja muito bem vindo ao mundo de Dart Ligth Blink",
	"Você está preparado para passar muitos momentos de raiva?",
	"Você será testado em várias habilidades nesse modo Ligth.",
	"No entanto, temos um modo Dark, o que nos leva a um nível maior de paciencia.",
	"Não entre no modo Dark se não for capaz de passar desafios impo... digo, quase impossíves.",
	".......",
	".......",
	".......",
	"Você está esperando eu dizer onde está a porta para o mundo Dark?",
	"Você deve descobrir."
]

func _unhandled_input(event):
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()
		if event.is_action_pressed("interact") && !DialogManager.is_message_active:
			texture.hide()
			DialogManager.start_message(global_position, lines)
		#else: 
			#texture.hide()
			#if DialogManager.dialog_box != null:
				#DialogManager.is_message_active = false
				##alogManager.dialog_box.queue_free()
