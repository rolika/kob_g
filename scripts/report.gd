extends Container

const DATE_FMT: String = "%s.%s.%s."
const DATE: String = "%s, %s"

func _ready() -> void:
    var cellstyle = StyleBoxFlat.new()
    cellstyle.bg_color = Color(0, 0, 0, 0.0)
    cellstyle.border_color = Color(0, 0, 0)
    cellstyle.set_border_width_all(1)
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
        singlevolume.text = CurrentPile.get_single_volume(cube)
        singlevolume.add_theme_stylebox_override("normal", cellstyle)
        singlevolume.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
        var volume: Label = Label.new()
        volume.text = CurrentPile.get_volume_for(cube)
        volume.add_theme_stylebox_override("normal", cellstyle)
        volume.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
        if CurrentPile.counter[cube] < 1:            
            diameter.add_theme_color_override("font_color", Color.GRAY)
            quantity.add_theme_color_override("font_color", Color.GRAY)
            singlevolume.add_theme_color_override("font_color", Color.GRAY)
            volume.add_theme_color_override("font_color", Color.GRAY)
        $Report/ReportGrid.add_child(diameter)
        $Report/ReportGrid.add_child(quantity)
        $Report/ReportGrid.add_child(singlevolume)
        $Report/ReportGrid.add_child(volume)
        index += 1
    var volume_label: Label = Label.new()
    volume_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
    var volume_value: Label = Label.new()
    volume_value.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
    var spacer1: Label = Label.new()
    var spacer2: Label = Label.new()
    volume_label.text = "összesen:"
    volume_value.text = CurrentPile.get_total_volume_formatted()
    spacer1.text = ""
    spacer2.text = ""
    $Report/ReportGrid.add_child(volume_label)
    $Report/ReportGrid.add_child(spacer1)
    $Report/ReportGrid.add_child(spacer2)
    $Report/ReportGrid.add_child(volume_value)
    var today = Time.get_date_dict_from_system()
    var date_fmt = DATE_FMT % [today.year, today.month, today.day]
    $Report/DateLabel.text = DATE % [CurrentPile.city, date_fmt]
    $Report/PersonLabel.text = CurrentPile.person

func get_report_as_image() -> Image:
    var image_viewport: SubViewport = SubViewport.new()
    add_child(image_viewport)
    image_viewport.size = $Report.size
    image_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
    image_viewport.add_child($Report.duplicate())
    await RenderingServer.frame_post_draw
    var image: Image = image_viewport.get_texture().get_image()
    image_viewport.queue_free()
    return image
