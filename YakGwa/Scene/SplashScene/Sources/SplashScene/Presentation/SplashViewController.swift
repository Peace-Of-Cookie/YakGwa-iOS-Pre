//
//  SplashViewController.swift
//
//
//  Created by Kim Dongjoo on 6/3/24.
//

import Foundation
import UIKit

import CoreKit
import Util

import ReactorKit

public final class SplashViewController: UIViewController {
        // MARK: - Properties
    public var disposeBag : DisposeBag = DisposeBag()
    weak var coordinator: SplashCoordinator?
    
    // MARK: - UI Componenets
    private lazy var splashImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Yakgwa_Splash_Image", in: .module, with: nil)
        return imageView
    }()
    
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
        setUI()
    }
    // MARK: - Layout
    private func setUI() {
        view.backgroundColor = UIColor.primary100
        
        view.addSubview(splashImage)
        splashImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
    // MARK: - Binding
}
