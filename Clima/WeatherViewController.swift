import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "ENTER_APP_ID_HERE" // Create your account on openweather.org and then paste APP_ID here.
    

    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()

    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization() // This will show popup for permission
        locationManager.startUpdatingLocation()
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getWeatherData(url: String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let weatherJson: JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJson)
                
            } else {
                print("Error: \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection issues"
            }
        }
    }

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    func updateWeatherData(json: JSON) {
        
        if let tempResult = json["main"]["temp"].double {
            
            weatherDataModel.temperature = Int(tempResult - 273.15) // Temp from response is coming as Kelvin. So converting it to degree celcius.
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            updateUIWithWeatherData()
            
        } else {
            cityLabel.text = "Weather unavailable!"
        }
        
    }

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    func updateUIWithWeatherData() {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)°" // Degree symbol is added by holding control+cmd+spacebar
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation() // Stop updating the location once we get the valid result.
            locationManager.delegate = nil // To avoid multiple calls to API, since it will take few more seconds to stop location updates. Thst's why!
            print("longitude: \(location.coordinate.longitude)  latitude: \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            // params is a dictionary, which organizes a data as key-value pair
            let params: [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location unavailable"
    }
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    func userEnteredCityName(cityName: String) {
        let params: [String : String] = ["q" : cityName, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "changeCityName" {
            
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.changeCityDelegate = self
            
        }
    }
}


