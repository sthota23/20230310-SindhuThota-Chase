//
//  WeatherDetailsViewController.swift
//  SindhuWeatherTask
//
//  Created by Sindhu Thota on 09/03/23.
//

import UIKit
import CoreLocation

class WeatherDetailsViewController: UIViewController {
    
    // MARK: - User interface objects
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var weatherTableView: UITableView!
    
    // MARK: - ViewController properties
    var viewModel = WeatherDetailsViewModel(apimanager: APIManager.shared)
    var locationManager: CLLocationManager?
    
    // MARK: - ViewController delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNib()
        addShadows()
        checkLastCityNameAndUpdateLocation()
    }
    
    // MARK: - Utilities
    private func loadNib() {
        weatherTableView.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressTableViewCell")
        weatherTableView.register(UINib(nibName: "DailyWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyWeatherTableViewCell")
        weatherTableView.register(UINib(nibName: "HourleyTableViewCell", bundle: nil), forCellReuseIdentifier: "HourleyTableViewCell")
    }
    
    private func addShadows(){
        /// adding shadow to subviews
        overlayView.layer.addshadowToLayer(color: UIColor(named: "textColot")!, radius: 8)
    }
    
    private func checkLastCityNameAndUpdateLocation() {
        let cityName = UserDefaults.getUserLocation()
        if !cityName.isEmpty {
            searchTextfield.text = cityName
            getCityDetails(cityName: cityName)
        } else {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.requestAlwaysAuthorization()
            locationManager?.startUpdatingLocation()
        }
    }
    
    // MARK: - Network Methods
    func getWeatherData() {
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.main.async {
                LoadingOverlay.shared.showOverlay(view: self.view)
            }
            viewModel.getWeatherResults() { [weak self] (status, message) in
                LoadingOverlay.shared.hideOverlayView()
                if status {
                    DispatchQueue.main.async {
                        self?.weatherTableView.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.showAlert(title: message ?? "", message: "", actionTitle: "Okay")
                    }
                }
            }
        } else {
            displayNetworkFailureAlert()
        }
    }
    
    func getCityDetails(cityName: String) {
        if Reachability.isConnectedToNetwork() {
            UserDefaults.saveUserLocation(cityName: cityName)
            LoadingOverlay.shared.showOverlay(view: self.view)
            viewModel.getCityWeatherDetails(cityName: cityName) { [weak self] (status, message) in
                LoadingOverlay.shared.hideOverlayView()
                if status {
                    self?.getWeatherData()
                } else {
                    DispatchQueue.main.async {
                        self?.showAlert(title: message ?? "", message: "", actionTitle: "Okay")
                    }
                }
            }
        } else {
            displayNetworkFailureAlert()
        }
    }
    
}

// MARK: - TableView DataSource Methods
extension WeatherDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.weatherData == nil || viewModel.weatherData?.hourly?.count == 0 ? 1 : 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.weatherData == nil || viewModel.weatherData?.hourly?.count == 0 {
            tableView.setFallbackView(withTitle: "Oops!",withText: "No Locations found")
            return 0
        } else {
            tableView.restore()
            return section == 2 ? viewModel.weatherData?.hourly?.count ?? 0 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return cellForAddress(indexPath: indexPath)
        case 1:
            return cellForDailyWeather(indexPath: indexPath)
        default:
            return cellForHourlyWeather(indexPath: indexPath)
        }
    }

    /// Provides Address Cell
    private func cellForAddress(indexPath: IndexPath) -> AddressTableViewCell {
        let addressCell = weatherTableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell") as? AddressTableViewCell
        addressCell?.weatherData = viewModel.weatherData
        addressCell?.selectionStyle = .none
        return addressCell ?? AddressTableViewCell()
    }

    /// Provides Daily Cell
    private func cellForDailyWeather(indexPath: IndexPath) -> DailyWeatherTableViewCell {
        let dailyCell = weatherTableView.dequeueReusableCell(withIdentifier: "DailyWeatherTableViewCell") as? DailyWeatherTableViewCell
            dailyCell?.weatherData = viewModel.weatherData
        dailyCell?.selectionStyle = .none
        return dailyCell ?? DailyWeatherTableViewCell()
    }

    /// Provides Hourly Cell
    private func cellForHourlyWeather(indexPath: IndexPath) -> HourleyTableViewCell {
        let hourlyCell = weatherTableView.dequeueReusableCell(withIdentifier: "HourleyTableViewCell") as? HourleyTableViewCell
        if viewModel.weatherData?.hourly?[indexPath.item].weather?.count ?? 0 > 0 {
            let imageUrl = ImageServiceUrlEndpoint.getWeatherImage(name: viewModel.weatherData?.hourly?[indexPath.item].weather?[0].icon ?? "").url()
            hourlyCell?.weatherImageView.loadImageFromServerURL(imageUrl, placeHolder: UIImage())
            hourlyCell?.tempLabel.text = "\(viewModel.weatherData?.hourly?[indexPath.item].temp ?? 0)\("°C") / \(viewModel.weatherData?.hourly?[indexPath.item].weather?[0].main ?? "")"
        }
        hourlyCell?.timeLabel.text = self.getDate(unixdate: viewModel.weatherData?.hourly?[indexPath.item].dt ?? 0, timezone: "EST", dateFormat: "h:mm a")
        hourlyCell?.selectionStyle = .none
        return hourlyCell ?? HourleyTableViewCell()
    }

}
// MARK: - TableView Delegate Methods
extension WeatherDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = WeatherDetailsTableHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.sectionHeaderLabel.text = section == 1 ? "Daily" : "Hourley"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 30
    }
}

// MARK: - Textfield Delegate Methods
extension WeatherDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        DispatchQueue.main.async {
            self.weatherTableView.reloadData()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 3 {
            getCityDetails(cityName: textField.text ?? "")
        } else {
            UserDefaults.saveUserLocation(cityName: textField.text ?? "")
            self.viewModel.weatherData = nil            
        }
    }
}

// MARK: - CLLocation Delegate Methods
extension WeatherDetailsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let location = locations.last else {
             return
        }
        let coord = Coord(lon: location.coordinate.longitude, lat: location.coordinate.latitude)
        viewModel.updateCoordinateLocation(location: coord)
        locationManager?.stopUpdatingLocation()
        locationManager?.delegate = nil
        getWeatherData()
    }
}


