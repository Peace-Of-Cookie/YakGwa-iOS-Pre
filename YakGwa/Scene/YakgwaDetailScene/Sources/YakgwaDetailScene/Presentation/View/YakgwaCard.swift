//
//  YakgwaCard.swift
//
//
//  Created by Ekko on 6/6/24.
//

import UIKit

import CoreKit

enum YakgwaCardType {
    case noParticipants
    case participants
}

final class YakgwaCardView: UIView {
    private let type: YakgwaCardType
    
    private lazy var themeTag: TagView = {
        let view = TagView(tag: "테마명")
        return view
    }()
    
    private lazy var meetTitle: UILabel = {
        let label = UILabel()
        label.font = .h3
        label.textColor = .neutralBlack
        label.text = "약과장의 약과모임"
        return label
    }()
    
    private lazy var meetDescription: UILabel = {
        let label = UILabel()
        label.font = .m14
        label.textColor = .neutral500
        label.text = "모임 설명입니다. 모임 설명입니다."
        return label
    }()
    
    private lazy var expireTime: UILabel = {
        let label = UILabel()
        label.font = .sb14
        label.textColor = .primary800
        label.text = "N시간 뒤 초대 마감"
        return label
    }()
    
    private lazy var participantsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .neutral200
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var participantsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .neutral600
        label.font = .r14
        label.text = "아직 참여중인 사람이 없습니다.\n초대장을 보내 약속을 진행해보세요."
        return label
    }()
    
    private lazy var inviteButton: YakGwaButton = {
        let button = YakGwaButton(style: .secondary)
        button.title = "초대하기"
        button.buttonImage = UIImage(named: "share_icon", in: .module, with: nil)
        return button
    }()
    
    init(type: YakgwaCardType) {
        self.type = type
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .neutralWhite
        self.layer.cornerRadius = 16
        
        self.addSubview(themeTag)
        themeTag.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(meetTitle)
        meetTitle.snp.makeConstraints {
            $0.top.equalTo(themeTag.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(meetDescription)
        meetDescription.snp.makeConstraints {
            $0.top.equalTo(meetTitle.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(expireTime)
        expireTime.snp.makeConstraints {
            $0.top.equalTo(meetDescription.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(participantsContainer)
        participantsContainer.snp.makeConstraints {
            $0.top.equalTo(expireTime.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(72)
        }
        
        participantsContainer.addSubview(participantsLabel)
        participantsLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        self.addSubview(inviteButton)
        inviteButton.snp.makeConstraints {
            $0.top.equalTo(participantsContainer.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
}
