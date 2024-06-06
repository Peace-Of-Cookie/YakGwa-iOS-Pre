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
    private lazy var placeTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PlaceCell.self, forCellReuseIdentifier: PlaceCell.identifier)
        return tableView
    }()
    
    private lazy var bottomButtonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .neutralWhite
        view.layer.applySketchShadow(color: .neutral600, alpha: 0.2, x: 0, y: -1, blur: 20, spread: 0)
        return view
    }()

    private lazy var confirmButton: YakGwaButton = {
        let button = YakGwaButton()
        button.title = "투표 완료"
        return button
    }()
    
    // MARK: - Initializers
    public init(reactor: PlaceVoteViewReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .neutral200
        self.setUI()
    }
    // MARK: - Layout
    private func setUI() {
        self.view.addSubview(placeTableView)
        placeTableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        self.view.addSubview(bottomButtonContainer)
        bottomButtonContainer.snp.makeConstraints {
            $0.height.equalTo(92)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        bottomButtonContainer.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Binding
    public func bind(reactor: PlaceVoteViewReactor) {
        // Action
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppeared }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .map { $0.places }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] places in
                print("테스트 \(places)")
            }).disposed(by: disposeBag)
        
        reactor.state
            .map { $0.places ?? [] }
            .distinctUntilChanged()
            .bind(to: placeTableView.rx.items(cellIdentifier: PlaceCell.identifier, cellType: PlaceCell.self)) { index, place, cell in
                cell.configure(place: place)
            }.disposed(by: disposeBag)
    }
}
