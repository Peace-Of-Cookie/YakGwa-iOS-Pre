//
//  YakGwaDefaultCardView.swift
//
//
//  Created by Kim Dongjoo on 6/3/24.
//

import UIKit

import CoreKit
import Util

final class YakGwaDefaultCardView: UIView, UIComponentBased {
    // MARK: - Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - UI Components
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() {
        
    }
    
    func layout() {
        <#code#>
    }
}
