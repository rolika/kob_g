extends Control

var pile: Pile = null

func _ready() -> void:
    if pile != null:
        $GridContainer/CompanyLabel.text = pile.company
        $GridContainer/CityLabel.text = pile.city
        $GridContainer/SiteLabel.text = pile.site
        $GridContainer/TypeLabel.text = pile.type    

func _process(_delta: float) -> void:
    if pile != null:
        $GridContainer/LengthLabel.text = pile.get_length_fmt()
        $GridContainer/VolumeLabel.text = pile.get_total_volume_fmt()

func set_pile(pile_arg: Pile) -> void:
    pile = pile_arg
