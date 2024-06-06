//
//  File.swift
//  
//
//  Created by Ekko on 6/6/24.
//

import UIKit

/// 테크 뷰
public final class TagView: UIView {
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.font = .sb14
        label.textColor = UIColor.secondary700
        return label
    }()
    
    public init(tag: String) {
        super.init(frame: .zero)
        tagLabel.text = tag
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.layer.borderColor = UIColor.secondary700.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 16
        
        addSubview(tagLabel)
        
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(8)
            $0.leading.equalTo(16)
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
