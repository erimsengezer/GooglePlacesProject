//
//  ViewController.swift
//  TestGoogleApi
//
//  Created by Erim Şengezer on 18.05.2022.
//

import UIKit
import GooglePlaces

class ViewController: UIViewController {

    private var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        label.text = "Result"
        return label
    }()

    override func viewDidLoad() {
        makeButton()
        configureLabel()
    }

    func configureLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)

        NSLayoutConstraint(
            item: label,
            attribute: NSLayoutConstraint.Attribute.centerX,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self.view,
            attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true

        NSLayoutConstraint(
            item: label,
            attribute: NSLayoutConstraint.Attribute.centerY,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self.view,
            attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true

    }

    // Present the Autocomplete view controller when the button is pressed.
    @objc func autocompleteClicked(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self

        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                  UInt(GMSPlaceField.placeID.rawValue))
        autocompleteController.placeFields = fields

        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter

        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }

    // Add a button to the view.
    func makeButton() {
        let btnLaunchAc = UIButton(frame: CGRect(x: 5, y: 150, width: 300, height: 35))
        btnLaunchAc.backgroundColor = .blue
        btnLaunchAc.setTitle("Launch autocomplete", for: .normal)
        btnLaunchAc.addTarget(self, action: #selector(autocompleteClicked), for: .touchUpInside)
        self.view.addSubview(btnLaunchAc)
    }
}

extension ViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    print("Place name: \(place.name)")
    print("Place ID: \(place.placeID)")
    print("Place attributions: \(place.attributions)")
      if let placeName = place.name {
          self.label.text = placeName
      }
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: - handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

}
