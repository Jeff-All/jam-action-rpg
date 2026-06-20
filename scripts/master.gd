class_name Master

extends MarginContainer

@export var available_campaigns: Array[CampaignOptions]

var main_menu
var options
var campaign_builder: CampaignBuilder
var campaign: Campaign

func _ready():
	main_menu = $MainMenu
	options = $Options
	campaign_builder = $CampaignBuilder
	campaign = $Campaign
	
	campaign_builder.start(available_campaigns)
	
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

func _campaign_builder_on_finish(campaign_options: CampaignOptions, party: Array[CharacterCampaign]):
	campaign.start(campaign_options, party)
	
	campaign_builder.visible = false
	campaign.visible = true
