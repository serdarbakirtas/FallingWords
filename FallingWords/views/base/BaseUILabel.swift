//
//  BaseUILabel.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//

import UIKit

class BaseUILabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    // MARK: FUNCTIONS
    private func configureTextField() {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 16)
        adjustsFontSizeToFitWidth = true
        backgroundColor = ColorPallet.TILE_ELEMENT
        textColor = ColorPallet.ON_TILE_ELEMENT
    }
}
