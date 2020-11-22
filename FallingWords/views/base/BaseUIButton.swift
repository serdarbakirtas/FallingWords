//
//  BaseUIButton.swift
//  FallingWords
//
//  Created by Hasan on 22.11.20.
//

import UIKit

class BaseUIButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    // MARK: FUNCTIONS
    private func configureButton() {
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        setTitleColor(ColorPallet.ON_TILE_ELEMENT, for: .normal)
        backgroundColor = ColorPallet.TILE_ELEMENT
    }
}
