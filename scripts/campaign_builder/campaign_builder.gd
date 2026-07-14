class_name CampaignBuilder

extends Control

signal on_exit()
signal on_finish(campaign: Campaign)

var available_campaigns: Array[CampaignOptions]
var attack: Ability

var campaign_selector
var party_builder: PartyBuilder

func _ready():
	campaign_selector = $CampaignSelector
	party_builder = $PartyBuilder
	
	campaign_selector.visible = false
	party_builder.visible = false

func start(_available_campaigns: Array[CampaignOptions], _attack: Ability):
	available_campaigns = _available_campaigns
	attack = _attack
	
	campaign_selector.show_campaigns(available_campaigns)
	
	campaign_selector.visible = true

func _on_campaign_selector_on_cancel_pressed():
	on_exit.emit()

var cur_selected_campaign: CampaignOptions

func _on_campaign_selector_on_continue_pressed(campaign: CampaignOptions):
	cur_selected_campaign = campaign
	party_builder.start(campaign)
	campaign_selector.visible = false
	party_builder.visible = true

func _on_party_builder_on_cancel():
	party_builder.visible = false
	
	campaign_selector.show_campaigns(available_campaigns)
	
	campaign_selector.visible = true

func _on_party_builder_on_finish(characters: Array[CharacterBase]):
	var party: Array[CharacterCampaign]
	for cur in characters:
		party.append(cur.get_character_campaign(attack))
	
	var campaign = Campaign.new(cur_selected_campaign, party)
	
	on_finish.emit(campaign)
