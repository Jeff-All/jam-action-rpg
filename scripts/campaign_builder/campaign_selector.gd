class_name CampaignSelector

extends PanelContainer

signal on_cancel_pressed()
signal on_continue_pressed(campaign: CampaignOptions)

var available_campaigns: Array[CampaignOptions]

var title: Label
var left: SimpleButton
var right: SimpleButton

var cur_campaign_index: int = 0

func _ready():
	title = $MarginContainer/Header/Title
	
	left = $MarginContainer/HBoxContainer/Left
	right = $MarginContainer/HBoxContainer/Right
	
	
	left.visible = false
	right.visible = false
	
	left.disabled = false
	right.disabled = false
	
	$MarginContainer/Footer/MarginContainer/Cancel.disabled = false
	$MarginContainer/Footer/MarginContainer/Continue.disabled = false

func show_campaigns(_available_campaigns: Array[CampaignOptions]):
	available_campaigns = _available_campaigns
	cur_campaign_index = 0
	
	left.visible = false
	right.visible = false
	
	if available_campaigns.size() > 1:
		left.visible = true
		right.visible = true
	
	show_campaign()

func show_campaign():
	var cur_campaign = available_campaigns[cur_campaign_index] 
	title.text = cur_campaign.name

func _on_left_pressed(_simple_button: SimpleButton):
	cur_campaign_index = posmod(cur_campaign_index - 1, available_campaigns.size())
	show_campaign()

func _on_right_pressed(_simple_button: SimpleButton):
	cur_campaign_index = (cur_campaign_index + 1) % available_campaigns.size()
	show_campaign()

func _on_cancel_pressed(_simple_button: SimpleButton):
	on_cancel_pressed.emit()

func _on_continue_pressed(_simple_button: SimpleButton):
	on_continue_pressed.emit(available_campaigns[cur_campaign_index])
