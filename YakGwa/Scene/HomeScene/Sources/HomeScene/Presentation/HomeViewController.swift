//
//  HomeViewController.swift
//  
//
//  Created by Kim Dongjoo on 6/3/24.
//

import UIKit

import CoreKit
import Util

import ReactorKit
import RxCocoa

public final class HomeViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    public var coordinator: HomeCoordinator?
    // MARK: - UI Componenets
    private var cardView: YakGwaHomeCardView = {
        let cardView = YakGwaHomeCardView()
        return cardView
    }()
    
    // MARK: - Initializers
    public init(reactor: HomeReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    // MARK: - Binding
    public func bind(reactor: HomeReactor) {
        // Action
        cardView.confirmbutton.rx.tap
            .map { Reactor.Action.moveToMakeAppointment }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .map { $0.shouldNavigateToMakeAppointment }
            .distinctUntilChanged()
            .filter { $0 }
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator?.moveToMakeYakgwa()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Layout
    private func setUI() {
        self.view.backgroundColor = .neutral200
        
        self.view.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(32)
            $0.centerX.equalToSuperview()
        }
    }
}
