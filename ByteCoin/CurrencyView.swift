//
//  CurrencyView.swift
//  ByteCoin
//
//  Created by Вова on 17.02.2023.
//

import UIKit

class CurrencyView: UIView {
    let byteImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bitcoin")
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let rateLabel : UILabel = {
        let label = UILabel ()
        label.text = "..."
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currencyLabel : UILabel = {
        let label = UILabel ()
        label.text = "USD"
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init (frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.5366684794, green: 0.759000361, blue: 0.7686197162, alpha: 1)
        layer.cornerRadius = 40
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        rateLabel.font = UIFont(name: "Avenir", size: frame.height/2.8)
        currencyLabel.font = UIFont(name: "Avenir", size: frame.height/2.8)
    }
    
    func setupViews() {
        addSubview(byteImageView)
        addSubview(rateLabel)
        addSubview(currencyLabel)
    }
    
    func setConstraints () {
        NSLayoutConstraint.activate([
            byteImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            byteImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            byteImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            byteImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            rateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            rateLabel.leadingAnchor.constraint(equalTo: byteImageView.trailingAnchor, constant: 0),
            rateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            rateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            currencyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            currencyLabel.leadingAnchor.constraint(equalTo: rateLabel.trailingAnchor, constant: 0),
            currencyLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            currencyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            currencyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
        
        

    }
    
}
