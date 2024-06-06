//
//  CalendarVoteViewController.swift
//
//
//  Created by Ekko on 6/6/24.
//

import UIKit

import CoreKit
import Util

import ReactorKit
import RxCocoa

public final class CalendarVoteViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    public var coordinator: CalendarVoteCoordinator?
    
    // MARK: - UI Components
    
    // MARK: - Initializers
    public init(reactor: CalendarVoteReactor) {
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
        self.view.backgroundColor = .systemMint
    }
    // MARK: - Binding
    public func bind(reactor: CalendarVoteReactor) {
        
    }
}
