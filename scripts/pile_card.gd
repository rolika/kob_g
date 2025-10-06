extends Control

var pile: Pile

func _init(pile_arg: Pile = CurrentPile) -> void:
    pile = pile_arg

func _process(_delta: float) -> void:
    $CompanyLabel.text = pile.company
    $CityLabel.text = pile.city
    $SiteLabel.text = pile.site
    $TypeLabel.text = pile.type
    $LengthLabel.text = "%.2f m" % pile.length
    $VolumeLabel.text = "%.2f m3" % pile.get_total_volume()
