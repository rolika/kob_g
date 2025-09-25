extends ColorRect

const HEADER: String = "%s, %s, rakodóhely: %s\n%.2f m hosszú %s rönkök, összesen: %.2f m3"
const LINE: String = "átmérő: %d cm; %d db x %.2f m3/db = %.2f m3"
const DATE: String = "%s, %s"

func _ready() -> void:
    var report_text: String = ""
    var index = 0
    for cube in CurrentPile.counter:
        if CurrentPile.counter[cube] > 0:
            report_text += LINE % [
                index + CurrentPile.STARTING_DIAMETER,
                CurrentPile.counter[cube], 
                cube * CurrentPile.CUBE_DATA_PRECISION, 
                CurrentPile.get_volume(cube)]
            report_text += "     " if index % 2 == 0 else "\n"
            index += 1
    $HeaderLabel.text = HEADER % [
        CurrentPile.company,
        CurrentPile.city, 
        CurrentPile.site, 
        CurrentPile.length, 
        CurrentPile.type, 
        CurrentPile.get_total_volume()]
    $ReportLabel.text = report_text
    $DateLabel.text = DATE % [CurrentPile.city, Time.get_date_string_from_system()]
    $PersonLabel.text = CurrentPile.person
