//
//  JSONUrl.swift
//  weather
//
//  Created by Георгий on 04.02.2022.
//

import Foundation
func azimuit(deg:Int) -> String{
    var direction : String = ""
    switch deg {
    case 0...24 :
        direction = "С"
    case 25...69 :
        direction = "СВ"
    case 70...114 :
        direction = "B"
    case 115...159 :
        direction = "ЮB"
    case 160...204 :
        direction = "Ю"
    case 205...249 :
        direction = "ЮЗ"
    case 250...294 :
        direction = "З"
    case 295...339 :
        direction = "СЗ"
    case 340...359:
        direction = "C"
    default:
        print("error")
    }
    return direction
}
 

