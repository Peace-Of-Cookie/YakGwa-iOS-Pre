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
        self.view.backgroundColor = .systemMint
    }
    // MARK: - Layout
    
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
    }
}
