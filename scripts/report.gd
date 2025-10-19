extends ColorRect

const HEADER: String = "%s, %s, rakodóhely: %s\n%s hosszú %s rönkök, összesen: %s"
const LINE: String = "átmérő: %d cm; %d db x %s m3/db = %s m3"
const DATE_FMT: String = "%s.%s.%s."
const DATE: String = "%s, %s"

func _ready() -> void:
    var cellstyle = StyleBoxFlat.new()
    cellstyle.bg_color = Color(0, 0, 0, 0.0)
    cellstyle.border_color = Color(0, 0, 0)
    cellstyle.set_border_width_all(1)
    $HeaderLabel.text = HEADER % [
        CurrentPile.company,
        CurrentPile.city, 
        CurrentPile.site, 
        CurrentPile.get_length_fmt(), 
        CurrentPile.type, 
        CurrentPile.get_total_volume_fmt()]
    var index = 0
    for cube in CurrentPile.counter:
        var diameter: Label = Label.new()
        diameter.text = str(index + CurrentPile.STARTING_DIAMETER)
        diameter.add_theme_stylebox_override("normal", cellstyle)
        diameter.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
        var quantity: Label = Label.new()
        quantity.text = str(CurrentPile.counter[cube])
        quantity.add_theme_stylebox_override("normal", cellstyle)
        quantity.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
        var singlevolume: Label = Label.new()
        singlevolume.text = str(CurrentPile.translate_decimal(cube * CurrentPile.CUBE_DATA_PRECISION))
        singlevolume.add_theme_stylebox_override("normal", cellstyle)
        singlevolume.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
        var volume: Label = Label.new()
        volume.text = CurrentPile.translate_decimal(CurrentPile.get_volume(cube))
        volume.add_theme_stylebox_override("normal", cellstyle)
        volume.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
        if CurrentPile.counter[cube] < 1:            
            diameter.add_theme_color_override("font_color", Color.GRAY)
            quantity.add_theme_color_override("font_color", Color.GRAY)
            singlevolume.add_theme_color_override("font_color", Color.GRAY)
            volume.add_theme_color_override("font_color", Color.GRAY)
        $ReportGrid.add_child(diameter)
        $ReportGrid.add_child(quantity)
        $ReportGrid.add_child(singlevolume)
        $ReportGrid.add_child(volume)
        index += 1
    var today = Time.get_date_dict_from_system()
    var date_fmt = DATE_FMT % [today.year, today.month, today.day]
    $DateLabel.text = DATE % [CurrentPile.city, date_fmt]
    $PersonLabel.text = CurrentPile.person
    $PersonLabel.add_theme_color_override("font_color", Color.BLACK)
