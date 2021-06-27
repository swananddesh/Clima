import UIKit


protocol ChangeCityDelegate {
    func userEnteredCityName(cityName: String)
}


class ChangeCityViewController: UIViewController {
    
    var changeCityDelegate: ChangeCityDelegate?
    
    @IBOutlet weak var changeCityTextField: UITextField!

    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        
        
        //1 Get the city name the user entered in the text field
        let enteredCityName = changeCityTextField.text!
        
        //2 If we have a delegate set, call the method userEnteredANewCityName
        changeCityDelegate?.userEnteredCityName(cityName: enteredCityName)
        
        //3 dismiss the Change City View Controller to go back to the WeatherViewController
        self.dismiss(animated: true, completion: nil)
        
    }
    
    

    //This is the IBAction that gets called when the user taps the back button. It dismisses the ChangeCityViewController.
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
