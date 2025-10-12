extends ColorRect

const HEADER: String = "%s, %s, rakodóhely: %s\n%s hosszú %s rönkök, összesen: %s"
const LINE: String = "átmérő: %d cm; %d db x %s m3/db = %s"
const DATE: String = "%s, %s"

func _ready() -> void:
    var report_text: String = ""
    var index = 0
    for cube in CurrentPile.counter:
        if CurrentPile.counter[cube] > 0:
            report_text += LINE % [
                index + CurrentPile.STARTING_DIAMETER,
                CurrentPile.counter[cube], 
                CurrentPile.translate_decimal(cube * CurrentPile.CUBE_DATA_PRECISION), 
                CurrentPile.get_volume_fmt(cube)]
            report_text += "     " if index % 2 == 0 else "\n"
            index += 1
    $HeaderLabel.text = HEADER % [
        CurrentPile.company,
        CurrentPile.city, 
        CurrentPile.site, 
        CurrentPile.get_length_fmt(), 
        CurrentPile.type, 
        CurrentPile.get_total_volume_fmt()]
    $ReportLabel.text = report_text
    $DateLabel.text = DATE % [CurrentPile.city, Time.get_date_string_from_system()]
    $PersonLabel.text = CurrentPile.person
