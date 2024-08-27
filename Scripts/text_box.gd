extends MarginContainer

@export var label: Label
@onready var timer = $Timer 

const maxWidth = 512

var text = ""
var letterIndex = 0

var letterTime = 0.03
var spaceTime = 0.06
var punctuationTime = 0.02

var isLastChar = false

signal finishedDisplaying()

func displayText(textToDisplay: String):
  isLastChar = false
  text = textToDisplay
  label.text = textToDisplay

  await resized
  custom_minimum_size.x = min(size.x, maxWidth)

  if size.x > maxWidth: 
    label.autowrap_mode = TextServer.AUTOWRAP_WORD
    await resized
    await resized
    custom_minimum_size.y = size.y

  global_position.x -= size.x / 2
  global_position.y -= size.y + 24

  label.text = ""
  _displayLetter()

func _displayLetter():
  if letterIndex >= text.length()-1:
    if !isLastChar:
      label.text += text[letterIndex]
      isLastChar = true

    finishedDisplaying.emit()
    return
  label.text += text[letterIndex]

  letterIndex = min(letterIndex+1, text.length())

  match text[letterIndex]:
    '!', '.', ',', '?':
      timer.start(punctuationTime)
    ' ':
      timer.start(spaceTime)
    _:
      timer.start(letterTime)


func _on_timer_timeout():
  _displayLetter()
