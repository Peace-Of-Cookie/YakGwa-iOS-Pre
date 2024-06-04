//
//  SelectionView.swift
//
//
//  Created by Kim Dongjoo on 6/4/24.
//

import UIKit

import CoreKit
import Util

final class SelectionView: UIView, UIComponentBased {
    // MARK: - Properties
    private let type: SelectionViewType
    
    // MARK: - UI Components
    private lazy var separatorView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.textColor = .neutral500
        label.font = UIFont.r14
        return label
    }()
    
    private lazy var firstImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.textColor = .neutral500
        label.font = UIFont.r14
        return label
    }()
    
    private lazy var secondImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    // MARK: - Initializers
    init(type: SelectionViewType) {
        self.type = type
        
        super.init(frame: .zero)
        
        self.attribute()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    func attribute() {
        self.backgroundColor = .white
        self.separatorView.backgroundColor = .neutral200
        self.layer.cornerRadius = 15
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        switch type {
        case .date:
            firstLabel.text = "시작 날짜"
            firstImage.image = UIImage(named: "Calendar", in: .module, with: nil)
            secondLabel.text = "종료 날짜"
            secondImage.image = UIImage(named: "Calendar", in: .module, with: nil)
        case .time:
            firstLabel.text = "시작 시간"
            firstImage.image = UIImage(named: "Clock", in: .module, with: nil)
            secondLabel.text = "종료 시간"
            secondImage.image = UIImage(named: "Clock", in: .module, with: nil)
        }
    }
    
    func layout() {
        self.addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        self.addSubview(firstLabel)
        firstLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(firstImage)
        firstImage.snp.makeConstraints {
            $0.trailing.equalTo(separatorView.snp.leading).offset(-16)
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(secondLabel)
        secondLabel.snp.makeConstraints {
            $0.leading.equalTo(separatorView.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
        }
        
        self.addSubview(secondImage)
        secondImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
    }
}

/// 선택 창 타입
enum SelectionViewType {
    case date
    case time
}
