//
//  File.swift
//  
//
//  Created by Ekko on 6/8/24.
//

import UIKit
import RxCocoa
import CoreKit

final class YakgwaVotedCardView: UIView {
    // MARK: - Properties
    
    // MARK: - UI Components
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .primary700
        return view
    }()
    
    private lazy var headerLabel: UIView = {
        let label = UILabel()
        label.text = "투표를 완료했어요"
        label.font = .sb14
        label.textColor = .neutralWhite
        return label
    }()
    
    lazy var tagView: TagView = {
        let view = TagView(tag: "테마명")
        return view
    }()
    
    lazy var meetTitle: UILabel = {
        let label = UILabel()
        label.text = "약과장의 약과모임"
        label.font = .h3
        label.textColor = .neutralBlack
        return label
    }()
    
    lazy var meetDescription: UILabel = {
        let label = UILabel()
        label.text = "모임 설명입니다. 모임 설명입니다."
        label.font = .m14
        label.textColor = .neutral500
        return label
    }()
    
    private lazy var participantContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .neutral200
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var participantsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .neutral600
        label.font = .r14
        label.text = "아직 참여중인 사람이 없습니다."
        return label
    }()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setUI() {
        self.backgroundColor = .red
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        
        self.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        headerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(tagView)
        tagView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(meetTitle)
        meetTitle.snp.makeConstraints {
            $0.top.equalTo(tagView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(meetDescription)
        meetDescription.snp.makeConstraints {
            $0.top.equalTo(meetTitle.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.addSubview(participantContainer)
        participantContainer.snp.makeConstraints {
            $0.top.equalTo(meetDescription.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(72)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        participantContainer.addSubview(participantsLabel)
        participantsLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
