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

public final class HomeViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    public var reactor: HomeReactor
    public var coordinator: HomeCoordinator?
    // MARK: - UI Componenets
    
    // MARK: - Initializers
    public init(reactor: HomeReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycles
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.primary700
    }
    
    // MARK: - Binding
    public func bind(reactor: HomeReactor) {
        print("바인딩")
    }
    
    // MARK: - Layout
    private func setUI() {
        
    }
}
