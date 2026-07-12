extends MarginContainer

@onready var Dialogue = $VBoxContainer/Dialogue_Con/Dialogue
@onready var Char_Name = $VBoxContainer/Name_Con/CharacterName
@onready var timer = $LetterRenderer

var text = ""
var letter_index = 0
var MAX_WIDTH = 256

#dura = Duration
var letter_dura = 0.03
var space_dura = 0.06
var punc_dura = 0.02

signal done_display()

func display_dial(text_to_display : String):
	text = text_to_display
	Dialogue.text = text_to_display
	
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		Dialogue.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_maximum_size.y = size.y
		
	global_position.x -= size.x/2
	global_position.y -= size.y + 24
	
	Dialogue.text = ""
	_display_letter()

func _display_letter():
	Dialogue.text += text[letter_index]
	letter_index += 1
	
	if letter_index >= letter_index:
		done_display.emit()
		return
	
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punc_dura)
		" ":
			timer.start(space_dura)
		_:
			timer.start(letter_dura)


func _on_letter_renderer_timeout() -> void:
	_display_letter()
