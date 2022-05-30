//
//  model.swift
//  weather
//
//  Created by Георгий on 04.02.2022.
//



import Foundation

struct CityData : Codable{
  var data : [Dat] = []
}
struct Dat : Codable {
    var name : String
    var coord : Coord
    
}
struct Coord : Codable{
    var lon : Double = 0.0
    var lat : Double = 0.0
}


var nameOfAllCity : [(String,Double,Double)] = []
var result = CityData()

     func purse(){
        guard let path = Bundle.main.path(forResource: "cityList", ofType: "json") else {
            return
        }
     
    let url = URL(fileURLWithPath: path)
    do {
    let jsonData = try Data(contentsOf: url)
        result = try JSONDecoder().decode(CityData.self, from:jsonData )
    }catch{
        print("error\(error)")
    }
     for i in result.data{
         nameOfAllCity.append((i.name,i.coord.lat,i.coord.lon))
     }
}






