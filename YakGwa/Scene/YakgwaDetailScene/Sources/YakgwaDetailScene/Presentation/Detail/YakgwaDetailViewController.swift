//
//  YakgwaDetailViewController.swift
//
//
//  Created by Ekko on 6/6/24.
//

import UIKit

import CoreKit
import Util

import ReactorKit
import RxCocoa

public final class YakgwaDetailViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    public var coordinator: YakgwaDetailCoordinator?
    
    // MARK: - UI Components
    private lazy var card: YakgwaCardView = {
        let view = YakgwaCardView(type: .noParticipants)
        return view
    }()
    
    private lazy var bottomButtonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .neutralWhite
        view.layer.applySketchShadow(color: .neutral600, alpha: 0.2, x: 0, y: -1, blur: 20, spread: 0)
        return view
    }()

    private lazy var confirmButton: YakGwaButton = {
        let button = YakGwaButton()
        button.title = "시간 및 장소 투표하기"
        return button
    }()
    
    // MARK: - Initializers
    public init(reactor: YakgwaDetailReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: - Layout
    private func setUI() {
        self.view.backgroundColor = .neutral200
        
        self.view.addSubview(card)
        card.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalTo(16)
            $0.centerX.equalToSuperview()
        }
        
        self.view.addSubview(bottomButtonContainer)
        bottomButtonContainer.snp.makeConstraints {
            $0.height.equalTo(92)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        bottomButtonContainer.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    // MARK: - Binding
    public func bind(reactor: YakgwaDetailReactor) {
        // Action
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppeared}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .map { Reactor.Action.voteButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
            
        // State
        reactor.state.map { (state: YakgwaDetailReactor.State) -> String in
            guard let meetInfo = state.meetInfo else { return "" }
            return meetInfo.themeName ?? ""
        }.distinctUntilChanged()
            .bind(to: card.themeTag.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { (state: YakgwaDetailReactor.State) -> String in
            guard let meetInfo = state.meetInfo else { return "" }
            return meetInfo.name ?? ""
        }.distinctUntilChanged()
            .bind(to: card.meetTitle.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { (state: YakgwaDetailReactor.State) -> String in
            guard let meetInfo = state.meetInfo else { return "" }
            return meetInfo.description ?? ""
        }.distinctUntilChanged()
            .bind(to: card.meetDescription.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { (state: YakgwaDetailReactor.State) -> String in
            guard let meetInfo = state.meetInfo else { return "" }
            return "\(meetInfo.expiredAfter ?? "") 뒤 초대 마감"
        }.distinctUntilChanged()
            .bind(to: card.expireTime.rx.text)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$shouldNavigateToVoteScene)
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] meetId in
                print("투표 화면으로 이동:\(meetId)")
                self?.coordinator?.navigateToVoteScene(meetId: meetId)
            }).disposed(by: disposeBag)
            
    }
}
