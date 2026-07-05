class_name Master

extends MarginContainer

@export var attack: Ability
@export var available_campaigns: Array[CampaignOptions]

var main_menu
var options
var campaign_builder: CampaignBuilder
var campaign: CampaignUI

func _ready():
	main_menu = $MainMenu
	options = $Options
	campaign_builder = $CampaignBuilder
	campaign = $CampaignUI
	
	campaign_builder.start(available_campaigns, attack)
	
	main_menu.visible = true
	options.visible = false
	campaign_builder.visible = false
	campaign.visible = false

func _main_menu_on_campaigns_pressed():
	main_menu.visible = false
	campaign_builder.visible = true

func _main_menu_on_exit_pressed():
	pass

func _main_menu_on_options_pressed():
	main_menu.visible = false
	options.visible = true

func _campaign_builder_on_exit():
	campaign_builder.visible = false
	main_menu.visible = true

func _campaign_builder_on_finish(_campaign: Campaign):
	campaign.start(_campaign)
	
	campaign_builder.visible = false
	campaign.visible = true

func _campaign_ui_on_exit():
	campaign.visible = false
	
	main_menu.visible = true
