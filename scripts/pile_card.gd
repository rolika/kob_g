extends Control

var pile: Pile

func _init(pile_arg: Pile = CurrentPile) -> void:
    pile = pile_arg

func _process(_delta: float) -> void:
    $CompanyLabel.text = pile.company
    $CityLabel.text = pile.city
    $SiteLabel.text = pile.site
    $TypeLabel.text = pile.type
    $LengthLabel.text = "%s m" % translate_decimal(pile.length)
    $VolumeLabel.text = "%s m3" % translate_decimal(pile.get_total_volume())

func set_pile(pile_arg: Pile) -> void:
    pile = pile_arg

func translate_decimal(num: Variant) -> Variant:
    if is_instance_of(num, TYPE_FLOAT):
        var text = "%.2f" % num
        return text.replace(".", ",")
    elif is_instance_of(num, TYPE_STRING):
        return float(num.replace(",", "."))
    return -1
