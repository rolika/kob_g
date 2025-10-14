extends Control

var pile: Pile

func _init(pile_arg: Pile = CurrentPile) -> void:
    pile = pile_arg

func _process(_delta: float) -> void:
    $CompanyLabel.text = pile.company
    $CityLabel.text = pile.city
    $SiteLabel.text = pile.site
    $TypeLabel.text = pile.type
    $LengthLabel.text = pile.get_length_fmt()
    $VolumeLabel.text = pile.get_total_volume_fmt()

func set_pile(pile_arg: Pile) -> void:
    pile = pile_arg
