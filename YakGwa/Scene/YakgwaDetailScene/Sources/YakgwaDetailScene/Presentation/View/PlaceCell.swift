//
//  PlaceCell.swift
//
//
//  Created by Ekko on 6/7/24.
//

import UIKit

final class PlaceCell: UITableViewCell {
    static let identifier = "PlaceCell"
    
    private let placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let placeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .m14
        label.numberOfLines = 1
        label.textColor = .neutralBlack
        return label
    }()
    
    private let placeAddressLabel: UILabel = {
        let label = UILabel()
        label.font = .m11
        label.numberOfLines = 1
        label.textColor = .neutral700
        return label
    }()
    
    private let placeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "장소 설명입니다."
        label.font = .m11
        label.numberOfLines = 1
        label.textColor = .neutral500
        return label
    }()
    
    // Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        contentView.addSubview(placeImageView)
        placeImageView.snp.makeConstraints {
            $0.width.equalTo(88)
            $0.height.equalTo(88)
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
        }
        
        contentView.addSubview(placeNameLabel)
        placeNameLabel.snp.makeConstraints {
            $0.leading.equalTo(placeImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(placeImageView.snp.top)
        }
        
        contentView.addSubview(placeAddressLabel)
        placeAddressLabel.snp.makeConstraints {
            $0.leading.equalTo(placeImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(placeNameLabel.snp.bottom).offset(4)
        }
        
        contentView.addSubview(placeDescriptionLabel)
        placeDescriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(placeImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(placeAddressLabel.snp.bottom).offset(4)
        }
    }
    
    func configure(place: MeetVoteInfo.RecommendPlace, isSelected: Bool) {
        placeImageView.image = UIImage(named: "yakgwa_title", in: .module, with: nil)
        placeNameLabel.text = place.name
        placeAddressLabel.text = place.address
        placeDescriptionLabel.text = place.description
        contentView.backgroundColor = isSelected ? .primary100 : .neutralWhite
    }
}
