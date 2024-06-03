//
//  LocationTagView.swift
//
//
//  Created by Ekko on 6/4/24.
//

import UIKit

final class LocationTagView: UIView {
    // MARK: - Properties
    private let location: String
    
    // MARK: - UI Components
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "CancelButton", in: .module, with: nil), for: .normal)
        return button
    }()
    
    // MARK: - Initializers
    init(location: String) {
        self.location = location
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setUI() {
        locationLabel.text = location
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        
        self.addSubview(locationLabel)
        locationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        self.addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalTo(locationLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
}
