//
//  UserVoteStatusViewController.swift
//
//
//  Created by Ekko on 6/7/24.
//

import UIKit

import CoreKit
import Util

import ReactorKit
import RxCocoa

public final class UserVoteStatusViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    public var coordinator: UserVoteStatusCoordinator?
    
    // MARK: - UI Components
    private lazy var cardView: YakgwaVotedCardView = {
        let view = YakgwaVotedCardView()
        view.backgroundColor = .neutralWhite
        return view
    }()
    
    private lazy var votedContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .neutralWhite
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var votedLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 투표한 시간"
        label.font = .sb14
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var votedStackContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .neutral200
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var votedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var timeRevoteButton: YakGwaButton = {
        let button = YakGwaButton(style: .secondary)
        button.title = "시간 다시 투표하기"
        return button
    }()
    
    // MARK: - Initializers
    public init(reactor: UserVoteStatusReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .neutral200
        setUI()
    }
    // MARK: - Layout
    private func setUI() {
        self.view.backgroundColor = .neutral200
        
        self.view.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalTo(16)
            $0.centerX.equalToSuperview()
        }
        
        self.view.addSubview(votedContainer)
        votedContainer.snp.makeConstraints {
            $0.top.equalTo(cardView.snp.bottom).offset(16)
            $0.leading.equalTo(16)
            $0.centerX.equalToSuperview()
        }
        
        votedContainer.addSubview(votedLabel)
        votedLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        votedContainer.addSubview(votedStackContainer)
        votedStackContainer.snp.makeConstraints {
            $0.top.equalTo(votedLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        votedStackContainer.addSubview(votedStackView)
        votedStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        votedContainer.addSubview(timeRevoteButton)
        timeRevoteButton.snp.makeConstraints {
            $0.top.equalTo(votedStackView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Binding
    public func bind(reactor: UserVoteStatusReactor) {
        // Action
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppeared }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.userVoteStatus }
            .distinctUntilChanged()
            .subscribe(onNext: {[weak self] result in
                print("투표 현황: \(result)")
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.meetInfo }
            .distinctUntilChanged()
            .subscribe(onNext: {[weak self] result in
                print("모임 정보: \(result)")
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.meetTheme }
            .distinctUntilChanged()
            .bind(to: cardView.tagView.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.meetName }
            .distinctUntilChanged()
            .bind(to: cardView.meetTitle.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.meetDescription }
            .distinctUntilChanged()
            .bind(to: cardView.meetDescription.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.meetVotedTime }
            .distinctUntilChanged()
            .subscribe(onNext: {[weak self] result in
                result?.forEach { time in
                    let label = UILabel()
                    label.text = time
                    label.font = .m12
                    label.textColor = .neutral800
                    self?.votedStackView.addArrangedSubview(label)
                }
            }).disposed(by: disposeBag)
        
    }
}
