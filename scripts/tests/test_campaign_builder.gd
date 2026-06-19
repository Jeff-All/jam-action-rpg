extends MarginContainer

@export var available_campaigns_1: Array[CampaignOptions]
@export var available_campaigns_2: Array[CampaignOptions]

func test1():
	$CampaignBuilder.start(available_campaigns_1)

func test2():
	$CampaignBuilder.start(available_campaigns_2)


func _on_campaign_builder_on_exit():
	print("Exit")

func _on_campaign_builder_on_finish(campaign: CampaignOptions, party: Array[CharacterBase]):
	var party_string = ""
	
	for cur in party:
		if party_string != "": 
			party_string += "\n"
		party_string += "%s" % cur
	
	print("Finish\nCampaign:%s\nParty\n%s" % [campaign, party_string])
