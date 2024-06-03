//
//  File.swift
//  
//
//  Created by Ekko on 6/3/24.
//

import UIKit

import CoreKit
import Util

import ReactorKit

public final class MakeYakgwaViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    public var reactor: MakeYakgwaReactor
    public var coordinator: MakeYakgwaCoordinator?
    // MARK: - UI Componenets
    
    // MARK: - Initializers
    public init(reactor: MakeYakgwaReactor) {
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
    public func bind(reactor: MakeYakgwaReactor) {
    }
    
    // MARK: - Layout
    private func setUI() {
        self.view.backgroundColor = .neutral200
    }
}
