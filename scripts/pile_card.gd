extends Node2D

func _process(_delta: float) -> void:
    $CompanyLabel.text = CurrentPile.company
    $CityLabel.text = CurrentPile.city
    $SiteLabel.text = CurrentPile.site
    $TypeLabel.text = CurrentPile.type
    $LengthLabel.text = "%.2f m" % CurrentPile.length
    $VolumeLabel.text = "%.2f m3" % CurrentPile.get_total_volume()
