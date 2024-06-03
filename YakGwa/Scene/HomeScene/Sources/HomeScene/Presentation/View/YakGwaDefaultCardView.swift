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
    
    // MARK: - UI Components
    private lazy var yakgwaImageView: UIImageView = {
        let imageView = UIImageView()
        // Yakgwa_Image
        imageView.image = UIImage(named: "Yakgwa_Image", in: .module, with: nil)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 약속이 없어요"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var button: YakGwaPrimaryButton = {
        let button = YakGwaPrimaryButton()
        button.title = "약속 만들러 가기"
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.attribute()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() {
        self.layer.cornerRadius = 25
        self.backgroundColor = .white
    }
    
    func layout() {
        self.addSubview(yakgwaImageView)
        yakgwaImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(yakgwaImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(button)
        button.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
}
