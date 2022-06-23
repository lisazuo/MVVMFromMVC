//
//  WeatherViewController.swift
//  MTest
//
//  Created by lisa on 20/06/22.
//MVVM, bind viewmodel output to the views
//KVO/functional reactive programming/delegation, boxing(property observers to notify observers that a value has chaged)
//the view controller is only responsible for views.
//send input(changeLocation) bind output
import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet private weak var currentIcon: UIImageView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var currentSummaryLabel: UILabel!
    @IBOutlet private weak var forecastSummary: UILabel!
    
    private let viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }
    
    @IBAction func promptForLocation_click(_ sender: Any) {
        //1
        let alert = UIAlertController(
            title: "Choose location",
            message: "you can choose Beijing, Tokyo, Canada or New zealand",
            preferredStyle: .alert)
        alert.addTextField()
        //2
        let submitAction = UIAlertAction(
            title: "Submit",
            style: .default) { [unowned alert, weak self] _ in
                guard let newLocation = alert.textFields?.first?.text else { return }
                self?.viewModel.changeLocation(to: newLocation)
            }
        alert.addAction(submitAction)
        //3
        present(alert, animated: true)
    }
    
    
    /// MARK: define functionality
    func subscribe() {
        viewModel.locationName.bind { [weak self] locationName in
            self?.cityLabel.text = locationName
        }
        viewModel.date.bind { [weak self] date in
            self?.dateLabel.text = date
        }
        
        viewModel.icon.bind { [weak self] image in
            self?.currentIcon.image = image
        }
        
        viewModel.summary.bind { [weak self] summary in
            self?.currentSummaryLabel.text = summary
        }
        
        viewModel.forecastSummary.bind { [weak self] forecast in
            self?.forecastSummary.text = forecast
        }
    }
}
