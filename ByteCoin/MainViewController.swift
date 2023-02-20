//
//  ViewController.swift
//  ByteCoin
//
//  Created by Вова on 17.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    var coinManager = CoinManager()
    
    let topLabel : UILabel = {
        let label = UILabel ()
        label.text = "ByteCoin"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currencyView = CurrencyView()
    
    let pickerView : UIPickerView = {
        let picker = UIPickerView ()
        picker.contentMode = .center
        picker.layer.cornerRadius = 20
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.619093895, green: 0.9377764463, blue: 0.9547130466, alpha: 1)
        setupViews()
        setConstraints()
        pickerView.delegate = self
        coinManager.delegate = self
        pickerView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        topLabel.font = UIFont(name: "Avenir", size: view.frame.height/17)
    }
    
    func setupViews () {
        view.addSubview(topLabel)
        view.addSubview(currencyView)
        view.addSubview(pickerView)
    }
    
    
}

//MARK: - IPickerViewDataSource

extension MainViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: - UIPickerViewDelegate

extension MainViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let currency = coinManager.currencyArray[row]
        return currency
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = coinManager.currencyArray[row]
        coinManager.performRequest(with: currency)
    }
}



//MARK: - CoinManagerDelegate

extension MainViewController: CoinManagerDelegate {
    
    func didUpdateCurrency(_ rate: Double,for currency: String) {
        DispatchQueue.main.async {
            let rateString = String(format: "%.0f", rate)
            self.currencyView.rateLabel.text = rateString
            self.currencyView.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

//MARK: - Constraints

extension MainViewController {
    func setConstraints () {
        NSLayoutConstraint.activate([
            
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            topLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            currencyView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 10),
            currencyView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            currencyView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            currencyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            pickerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            pickerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
