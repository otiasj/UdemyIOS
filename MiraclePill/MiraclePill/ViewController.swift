//
//  ViewController.swift
//  MiraclePill
//
//  Created by Julien Saito on 3/9/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let states = [ "AK - Alaska",
                  "AL - Alabama",
                  "AR - Arkansas",
                  "AS - American Samoa",
                  "AZ - Arizona",
                  "CA - California",
                  "CO - Colorado",
                  "CT - Connecticut",
                  "DC - District of Columbia",
                  "DE - Delaware",
                  "FL - Florida",
                  "GA - Georgia",
                  "GU - Guam",
                  "HI - Hawaii",
                  "IA - Iowa",
                  "ID - Idaho",
                  "IL - Illinois",
                  "IN - Indiana",
                  "KS - Kansas",
                  "KY - Kentucky",
                  "LA - Louisiana",
                  "MA - Massachusetts",
                  "MD - Maryland",
                  "ME - Maine",
                  "MI - Michigan",
                  "MN - Minnesota",
                  "MO - Missouri",
                  "MS - Mississippi",
                  "MT - Montana",
                  "NC - North Carolina",
                  "ND - North Dakota",
                  "NE - Nebraska",
                  "NH - New Hampshire",
                  "NJ - New Jersey",
                  "NM - New Mexico",
                  "NV - Nevada",
                  "NY - New York",
                  "OH - Ohio",
                  "OK - Oklahoma",
                  "OR - Oregon",
                  "PA - Pennsylvania",
                  "PR - Puerto Rico",
                  "RI - Rhode Island",
                  "SC - South Carolina",
                  "SD - South Dakota",
                  "TN - Tennessee",
                  "TX - Texas",
                  "UT - Utah",
                  "VA - Virginia",
                  "VI - Virgin Islands",
                  "VT - Vermont",
                  "WA - Washington",
                  "WI - Wisconsin",
                  "WV - West Virginia", 
                  "WY - Wyoming"]
    
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var statePickerButton: UIButton!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var ZipTextField: UITextField!
    @IBOutlet weak var buyNowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statePicker.dataSource = self
        statePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stateButtonPress(_ sender: Any) {
        statePicker.isHidden = false
        countryLabel.isHidden = true
        countryTextField.isHidden = true
        zipLabel.isHidden = true
        ZipTextField.isHidden = true
        buyNowButton.isHidden = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statePickerButton.setTitle(states[row], for: .normal)
        statePicker.isHidden = true
        countryLabel.isHidden = false
        countryTextField.isHidden = false
        zipLabel.isHidden = false
        ZipTextField.isHidden = false
        buyNowButton.isHidden = false
    }
    
    @IBAction func onBuyNowClick(_ sender: Any) {
        performSegue(withIdentifier: "successfulPurchase", sender: self)
    }
}

