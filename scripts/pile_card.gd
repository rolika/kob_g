extends Control

var pile: Pile

func _init(pile_arg: Pile = CurrentPile) -> void:
    pile = pile_arg

func _process(_delta: float) -> void:
    $GridContainer/CompanyLabel.text = pile.company
    $GridContainer/CityLabel.text = pile.city
    $GridContainer/SiteLabel.text = pile.site
    $GridContainer/TypeLabel.text = pile.type
    $GridContainer/LengthLabel.text = pile.get_length_fmt()
    $GridContainer/VolumeLabel.text = pile.get_total_volume_fmt()

func set_pile(pile_arg: Pile) -> void:
    pile = pile_arg
