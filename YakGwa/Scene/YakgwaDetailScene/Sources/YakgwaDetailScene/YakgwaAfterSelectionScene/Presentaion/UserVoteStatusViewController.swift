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
    
    // MARK: - Layout
    
    // MARK: - Binding
    public func bind(reactor: UserVoteStatusReactor) {
        // Action
        
        // State
    }
}
