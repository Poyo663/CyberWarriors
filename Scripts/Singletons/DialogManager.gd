extends Node

@onready var textBoxScene = preload("res://Scenes/text_box.tscn")

var dialogLines: Array[String] = []
var currentLineIndex = 0

var textBox 
var textBoxPosition: Vector2

var isDialogActive = false
var canAdvanceLine = false

func startDialog(position: Vector2, lines: Array[String]):
  if isDialogActive:
    return

  dialogLines = lines
  textBoxPosition = position
  _showTextBox()

  isDialogActive = true

func _showTextBox():
  textBox = textBoxScene.instantiate()
  textBox.finishedDisplaying.connect(_onTextBoxFinishedDislaying)
  get_tree().root.add_child(textBox)
  textBox.global_position = textBoxPosition
  textBox.displayText(dialogLines[currentLineIndex])
  canAdvanceLine = false

func _onTextBoxFinishedDislaying():
  canAdvanceLine = true

func _unhandled_input(event):
  if(
  event.is_action_pressed("advance_dialog") &&
  isDialogActive &&
  canAdvanceLine
  ):
    textBox.queue_free()
    currentLineIndex += 1 

    if currentLineIndex >= dialogLines.size():
      isDialogActive = false
      currentLineIndex = 0
      return

    _showTextBox()
