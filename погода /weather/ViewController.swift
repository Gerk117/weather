//
//  ViewController.swift
//  weather
//
//  Created by Георгий on 04.02.2022.
//

import UIKit
import CoreLocation




class ViewController: UIViewController{
    var locationManager = CLLocationManager()
    var weatherData = WeatherData()
  
    
    
   
    
    @IBOutlet weak var nameOfCity: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var mainTemp: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var pickerOfCity: UIPickerView!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        purse()
        goLocationManager()
        pickerOfCity.dataSource = self
        pickerOfCity.delegate = self
    }
  
    @IBAction func action(_ sender: Any) {
        pickerOfCity.isHidden = false
    }
    
    
    func goLocationManager(){
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
      }
    func updateView (){
        nameOfCity.text = weatherData.name
        minTemp.text = String(" Макс:\(Int(weatherData.main.temp_min - 273.0))℃")
        maxTemp.text = String("Мин:\(Int(weatherData.main.temp_max - 273.0))℃")
        mainTemp.text = String("\(Int(weatherData.main.temp - 273.0))℃")
        pressure.text = String("""
                               Давление:
                               \(Int((Double(weatherData.main.pressure)/1.333))) мм.рт.ст.
                               """)
        humidity.text = String("""
                                Влажность:
                                \(weatherData.main.humidity)%
                                """)
        wind.text = String("""
Ветер:
\(weatherData.wind.speed) м/с \(azimuit(deg: weatherData.wind.deg))
""")
        
    }
        func updateWeatherInfo(lat:Double,lon:Double){
            let session = URLSession.shared
            let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(lat.description)&lon=\(lon.description)&appid=1301c5b355b6d2df30e5bb35859da8e4")!
            let task = session.dataTask(with: url) { (data, rsponse, error) in
                guard error == nil else {
                    print("Datatask error\(error!.localizedDescription)")
                    return
                }
                
                do {
                    self.weatherData = try! JSONDecoder().decode(WeatherData.self, from: data!)
                    DispatchQueue.main.async {
                        self.updateView()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    
    
}

extension ViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastlocation = locations.last{
            updateWeatherInfo(lat: lastlocation.coordinate.latitude, lon: lastlocation.coordinate.longitude)
        }
    }
}
extension ViewController : UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nameOfAllCity.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nameOfAllCity[row].0
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.search.text = nameOfAllCity[row].0
        self.pickerOfCity.isHidden = true
        updateWeatherInfo(lat: nameOfAllCity[row].1, lon: nameOfAllCity[row].2)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.search{
            self.pickerOfCity.isHidden = false
        }
    }
}

