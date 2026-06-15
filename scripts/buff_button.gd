class_name BuffButton

extends PanelContainer

var Icon: Texture2D:
	set(value):
		$MarginContainer/Image.texture = value

func set_buff(buff: BuffActive):
	Icon = buff.base.base.texture
