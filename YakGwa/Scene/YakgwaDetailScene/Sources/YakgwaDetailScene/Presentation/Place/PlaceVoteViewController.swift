//
//  PlaceVoteViewController.swift
//  
//
//  Created by Ekko on 6/7/24.
//

import UIKit

import CoreKit
import Util

import ReactorKit
import RxCocoa

public final class PlaceVoteViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    public var coordinator: PlaceVoteCoordinator?
    
    // MARK: - UI Components
    
    // MARK: - Initializers
    init(reactor: PlaceVoteViewReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemRed
    }
    // MARK: - Layout
    
    // MARK: - Binding
    public func bind(reactor: PlaceVoteViewReactor) {
        
    }
}
