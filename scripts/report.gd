extends ColorRect

const DATE_FMT: String = "%s.%s.%s."
const DATE: String = "%s, %s"

func _ready() -> void:
    var cellstyle = StyleBoxFlat.new()
    cellstyle.bg_color = Color(0, 0, 0, 0.0)
    cellstyle.border_color = Color(0, 0, 0)
    cellstyle.set_border_width_all(1)
    var company_label: Label = Label.new()
    var company_name: Label = Label.new()
    company_name.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    var city_label: Label = Label.new()
    var city_name: Label = Label.new()
    var site_label: Label = Label.new()
    var site_name: Label = Label.new()
    var type_label: Label = Label.new()
    var type_name: Label = Label.new()
    type_name.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    var length_label: Label = Label.new()
    var length_value: Label = Label.new()
    var volume_label: Label = Label.new()
    volume_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
    var volume_value: Label = Label.new()
    volume_value.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
    company_label.text = "erdőbirtokosság:"
    company_name.text = CurrentPile.company
    city_label.text = "helység:"
    city_name.text = CurrentPile.city
    site_label.text = "rakodóhely:"
    site_name.text = CurrentPile.site
    type_label.text = "fafajta:"
    type_name.text = CurrentPile.type
    length_label.text = "rönkhossz:"
    length_value.text = CurrentPile.get_length_fmt()
    volume_label.text = "összesen:"
    volume_value.text = CurrentPile.get_total_volume_fmt()
    $HeadGrid1.add_child(company_label)
    $HeadGrid1.add_child(company_name)
    $HeadGrid1.add_child(city_label)
    $HeadGrid1.add_child(city_name)
    $HeadGrid2.add_child(site_label)
    $HeadGrid2.add_child(site_name)
    $HeadGrid2.add_child(type_label)
    $HeadGrid2.add_child(type_name)
    $HeadGrid2.add_child(length_label)
    $HeadGrid2.add_child(length_value)
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
    var spacer1: Label = Label.new()
    var spacer2: Label = Label.new()
    spacer1.text = ""
    spacer2.text = ""
    $ReportGrid.add_child(volume_label)
    $ReportGrid.add_child(spacer1)
    $ReportGrid.add_child(spacer2)
    $ReportGrid.add_child(volume_value)
    var today = Time.get_date_dict_from_system()
    var date_fmt = DATE_FMT % [today.year, today.month, today.day]
    $DateLabel.text = DATE % [CurrentPile.city, date_fmt]
    $PersonLabel.text = CurrentPile.person
    $PersonLabel.add_theme_color_override("font_color", Color.BLACK)
