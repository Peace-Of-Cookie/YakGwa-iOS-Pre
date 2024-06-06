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

public final class YakgwaDetailViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - UI Components
    
    // MARK: - Initializers
    public init() {
        super.init(nibName: nil, bundle: nil)
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
    private func setUI() {
        
    }
    
    // MARK: - Binding
}
