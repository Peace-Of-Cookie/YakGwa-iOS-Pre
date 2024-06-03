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
    private lazy var cardView: YakGwaDefaultCardView = {
        let cardView = YakGwaDefaultCardView()
        return cardView
    }()
    
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
        
        setUI()
    }
    
    // MARK: - Binding
    public func bind(reactor: HomeReactor) {
        print("바인딩")
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
