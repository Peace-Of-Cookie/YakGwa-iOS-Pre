//
//  ViewController.swift
//  YakGwa
//
//  Created by Ekko on 5/19/24.
//

import UIKit

import DesignSystem

class ViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "YakGwa"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        setUI()
    }
    
    func setUI() {
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
    }
}

