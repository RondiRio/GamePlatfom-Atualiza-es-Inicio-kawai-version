extends MarginContainer

@onready var text_label: Label = $label_margin/txt
@onready var letter_timer_display: Timer = $letter_timer_display
const MAX_WIDTH = 256
var text = ""
var letter_index = 0

var letter_display_timer := 0.07
var space_display_timer := 0.05
var punctuaction_display_timer := 0.2 

signal text_display_finished()

func display_text(text_to_display: String):
	text = text_to_display
	letter_index = 0  # Reseta o índice para começar o texto
	text_label.text = ""  # Garante que o texto comece vazio
	adjust_size()
	display_letter()

func adjust_size():
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)

	if size.x > MAX_WIDTH:
		text_label.autowrap_mode = TextServer.AutowrapMode.AUTOWRAP_WORD
		await resized
		custom_minimum_size.y = size.y
		global_position.x -= size.x / 2
		global_position.y -= size.y + 24

func display_letter():
	if letter_index < text.length():  # Verifica se ainda há letras para mostrar
		text_label.text += text[letter_index]
		match text[letter_index]:
			"!", "?", ",", ".":
				letter_timer_display.start(punctuaction_display_timer)
			" ":
				letter_timer_display.start(space_display_timer)
			_:
				letter_timer_display.start(letter_display_timer)
		letter_index += 1
	else:
		emit_signal("text_display_finished")  # Emite o sinal quando o texto termina

func _on_letter_timer_display_timeout() -> void:
	display_letter()

func clear_text():
	text_label.text = ""  # Limpa o texto exibido
