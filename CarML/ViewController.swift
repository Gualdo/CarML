//
//  ViewController.swift
//  CarML
//
//  Created by De La Cruz, Eduardo on 12/12/2018.
//  Copyright © 2018 De La Cruz, Eduardo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var modelSegmentedControl: UISegmentedControl!
    @IBOutlet weak var extrasSwitch: UISwitch!
    @IBOutlet weak var kmsLabel: UILabel!
    @IBOutlet weak var kmsSlider: UISlider!
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Global Variables
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    let cars = Cars()
    
    // MARK: - Life Cicle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.setCustomSpacing(40, after: modelSegmentedControl)
        stackView.setCustomSpacing(40, after: extrasSwitch)
        stackView.setCustomSpacing(40, after: kmsSlider)
        stackView.setCustomSpacing(80, after: statusSegmentedControl)
        
        calculateValue()
    }
    
    // MARK: - Actions
    
    /**
     Calculates and show the value of the car
     
     Givven the millage of the car, it´s price is calculated and displayed with machine learning
     */
    @IBAction func calculateValue() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let formatedKms = formatter.string(for: kmsSlider.value) ?? "0"
        kmsLabel.text = "kilometraje: \(formatedKms) Kms"
        
        // Hacer el cálculo con el valor del coche con ML
        if let prediction = try? cars.prediction(modelo: Double(modelSegmentedControl.selectedSegmentIndex),
                                                 extras: extrasSwitch.isOn ? Double(0.0) : Double(1.0),
                                                 kilometraje: Double(kmsSlider.value),
                                                 estado: Double(statusSegmentedControl.selectedSegmentIndex)) {
            let clampValue = max(500, prediction.price)
            formatter.numberStyle = .currency
            priceLabel.text = formatter.string(for: clampValue)
        } else {
            priceLabel.text = "Error"
        }
    }
}
