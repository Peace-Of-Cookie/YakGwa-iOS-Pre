//
//  ThemeCell.swift
//
//
//  Created by Ekko on 6/4/24.
//

import UIKit

import Common

final class ThemeCell: UICollectionViewCell {
    static let identifier = "ThemeCell"
    
    private let themeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Yakgwa_Theme_Default", in: .module, with: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let themeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.text = "테마명"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        themeImageView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height - 50)
//        themeLabel.frame = CGRect(x: 0, y: contentView.height - 50, width: contentView.width, height: 50)
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        themeImageView.image = nil
        themeLabel.text = nil
    }
    
    private func setUI() {
        self.contentView.addSubview(themeImageView)
        themeImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        self.contentView.addSubview(themeLabel)
        themeLabel.snp.makeConstraints {
            $0.top.equalTo(themeImageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func configure() {
    }
}
