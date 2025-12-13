extends Control

func _ready() -> void:
    $VBoxContainer/GridContainer/CompanyLabel.text = CurrentPile.company
    $VBoxContainer/GridContainer/CityLabel.text = CurrentPile.city
    $VBoxContainer/GridContainer2/SiteLabel.text = CurrentPile.site
    $VBoxContainer/GridContainer2/TypeLabel.text = CurrentPile.type
    $VBoxContainer/GridContainer2/LengthLabel.text = CurrentPile.get_length_formatted()
    $VBoxContainer/GridContainer/TotalVolumeLabel.text = CurrentPile.get_total_volume_formatted()

func _process(_delta: float) -> void:    
    $VBoxContainer/GridContainer/TotalVolumeLabel.text = CurrentPile.get_total_volume_formatted()
