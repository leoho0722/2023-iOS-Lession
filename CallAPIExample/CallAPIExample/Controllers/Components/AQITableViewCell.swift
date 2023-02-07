//
//  AQITableViewCell.swift
//  CallAPIExample
//
//  Created by Leo Ho on 2023/2/3.
//

import UIKit

class AQITableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var countyLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    
    // MARK: - Variables
    
    static let identifier = "AQITableViewCell"
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - UI Settings
    
    func setInit(county: String, status: String, aqi: Int) {
        countyLabel.text = county
        statusLabel.text = status
        aqiLabel.text = "\(aqi)"
        setupAQILabel(aqi: aqi)
    }
    
    private func setupAQILabel(aqi: Int) {
        switch aqi {
        case 0 ... 50:
            aqiLabel.backgroundColor = .systemGreen
        case 51 ... 100:
            aqiLabel.backgroundColor = .systemYellow
        case 101 ... 150:
            aqiLabel.backgroundColor = .systemOrange
        case 151 ... 200:
            aqiLabel.backgroundColor = .systemRed
        case 201 ... 300:
            aqiLabel.backgroundColor = .systemPurple
        case _ where aqi > 300:
            aqiLabel.backgroundColor = UIColor(red: CGFloat(188/255), green: CGFloat(143/255), blue: CGFloat(143/255), alpha: 1)
        default:
            break
        }
    }
    
    // MARK: - IBAction
    
}

// MARK: - Extensions



// MARK: - Protocol


