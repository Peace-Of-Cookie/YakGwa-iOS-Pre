//
//  MakeYakgwaViewController.swift
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
    public weak var coordinator: MakeYakgwaCoordinator?
    
    // MARK: - UI Componenets
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .neutral200
        return view
    }()
    
    private lazy var titleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "잡으려는 약속에 대해 알려주세요"
        label.textColor = .black
        return label
    }()
    
    private lazy var yakgwaTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "약속의 이름이 무엇인가요?"
        label.textColor = .black
        return label
    }()
    
    private lazy var yakgwaTitleInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var yakgwaTitleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "20자 이내로 입력해주세요."
        return textField
    }()
    
    private lazy var yakgwaTitleTextCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/20"
        label.textColor = .black
        return label
    }()
    
    private lazy var yakgwaDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "약속에 대해 설명해주세요"
        label.textColor = .black
        return label
    }()
    
    private lazy var yakgwaDescriptionInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var yakgwaDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "80자 이내로 입력해주세요."
        textView.textColor = .black
        textView.backgroundColor = .white
        return textView
    }()
    
    private lazy var yakgwaDescriptionTextCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/80"
        label.textColor = .black
        return label
    }()
    
    private lazy var themeLabel: UILabel = {
        let label = UILabel()
        label.text = "어떤 테마의 약속인가요?"
        label.textColor = .black
        return label
    }()
    
    private lazy var themeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(ThemeCell.self, forCellWithReuseIdentifier: ThemeCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "어디에서 모이나요?"
        label.textColor = .black
        return label
    }()
    
    private lazy var locationSubLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 3개 선택 가능"
        label.textColor = .black
        return label
    }()
    
    private lazy var alreadyLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "이미 장소를 정했어요"
        label.textColor = .black
        return label
    }()
    
    private lazy var alreadyLocationCheckBox: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "CheckBox", in: .module, with: nil), for: .normal)
        // button.setImage(UIImage(named: "CheckBox_Checked", in: .module, with: nil), for: .selected)
        return button
    }()
    
    private lazy var alreadyLocationInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var alreadyLocationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "지역/지하철역을 검색해주세요"
        return textField
    }()
    
    private lazy var alreadyLocationSearchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "SearchIcons", in: .module, with: nil), for: .normal)
        return button
    }()
    
    private lazy var locationStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 8
        return stack
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "언제부터 언제 사이에 모이나요?"
        label.textColor = .black
        return label
    }()
    
    private lazy var alreadyTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "이미 시간을 정했어요"
        label.textColor = .black
        return label
    }()
    
    private lazy var alreadyTimeCheckBox: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "CheckBox", in: .module, with: nil), for: .normal)
        // button.setImage(UIImage(named: "CheckBox_Checked", in: .module, with: nil), for: .selected)
        return button
    }()
    
    private lazy var selectDateLabel: UILabel = {
        let label = UILabel()
        label.text = "투표 가능한 기간을 선택해주세요 (최대 2주)"
        label.textColor = .black
        return label
    }()
    
    private lazy var daySelectionView: SelectionView = {
        let selectionView = SelectionView(type: .date)
        return selectionView
    }()
    
    private lazy var selectTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "투표 가능한 시간 범위를 선택해주세요"
        label.textColor = .black
        return label
    }()
    
    private lazy var timeSelectionView: SelectionView = {
        let selectionView = SelectionView(type: .time)
        return selectionView
    }()
    
    private lazy var expireTimerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "초대 마감 시간을 설정해주세요"
        label.textColor = .black
        return label
    }()
    
    private lazy var expireTimerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var expireTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "N시간 뒤 초대 마감"
        label.textColor = .black
        return label
    }()
    
    private lazy var changeExpireTimerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = .neutral200
        button.setTitle("변경하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - Initializers
    public init(reactor: MakeYakgwaReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        coordinator?.popMakeYakgwa()
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
        self.navigationItem.title = "약속 만들기"
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        self.contentView.addSubview(titleDescriptionLabel)
        titleDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.contentView.addSubview(yakgwaTitleLabel)
        yakgwaTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleDescriptionLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.contentView.addSubview(yakgwaTitleInputContainerView)
        yakgwaTitleInputContainerView.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(yakgwaTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.yakgwaTitleInputContainerView.addSubview(yakgwaTitleTextField)
        yakgwaTitleTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        self.yakgwaTitleInputContainerView.addSubview(yakgwaTitleTextCountLabel)
        yakgwaTitleTextCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(yakgwaDescriptionLabel)
        yakgwaDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(yakgwaTitleInputContainerView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.contentView.addSubview(yakgwaDescriptionInputContainerView)
        yakgwaDescriptionInputContainerView.snp.makeConstraints {
            $0.height.equalTo(91)
            $0.top.equalTo(yakgwaDescriptionLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.yakgwaDescriptionInputContainerView.addSubview(yakgwaDescriptionTextView)
        yakgwaDescriptionTextView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        self.yakgwaDescriptionInputContainerView.addSubview(yakgwaDescriptionTextCountLabel)
        yakgwaDescriptionTextCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        self.contentView.addSubview(themeLabel)
        themeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(yakgwaDescriptionInputContainerView.snp.bottom).offset(16)
        }
        
        self.contentView.addSubview(themeCollectionView)
        themeCollectionView.snp.makeConstraints {
            $0.top.equalTo(themeLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(100)
        }
        
        self.contentView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(themeCollectionView.snp.bottom).offset(16)
        }
        
        self.contentView.addSubview(locationSubLabel)
        locationSubLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(locationLabel.snp.bottom).offset(8)
        }
        
        self.contentView.addSubview(alreadyLocationCheckBox)
        alreadyLocationCheckBox.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(locationLabel)
        }
        
        self.contentView.addSubview(alreadyLocationLabel)
        alreadyLocationLabel.snp.makeConstraints {
            $0.trailing.equalTo(alreadyLocationCheckBox.snp.leading).offset(-8)
            $0.centerY.equalTo(locationLabel)
        }
        
        self.contentView.addSubview(alreadyLocationInputContainerView)
        alreadyLocationInputContainerView.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(locationSubLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.alreadyLocationInputContainerView.addSubview(alreadyLocationTextField)
        alreadyLocationTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        self.alreadyLocationInputContainerView.addSubview(alreadyLocationSearchButton)
        alreadyLocationSearchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(locationStack)
        locationStack.snp.makeConstraints {
            $0.top.equalTo(alreadyLocationInputContainerView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        self.locationStack.addArrangedSubview(LocationTagView(location: "홍대"))
        self.locationStack.addArrangedSubview(LocationTagView(location: "역삼역"))
        
        self.contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(locationStack.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.contentView.addSubview(alreadyTimeCheckBox)
        alreadyTimeCheckBox.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(timeLabel)
        }
        
        self.contentView.addSubview(alreadyTimeLabel)
        alreadyTimeLabel.snp.makeConstraints {
            $0.trailing.equalTo(alreadyTimeCheckBox.snp.leading).offset(-8)
            $0.centerY.equalTo(timeLabel)
        }
        
        self.contentView.addSubview(selectDateLabel)
        selectDateLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.contentView.addSubview(daySelectionView)
        daySelectionView.snp.makeConstraints {
            $0.top.equalTo(selectDateLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.contentView.addSubview(selectTimeLabel)
        selectTimeLabel.snp.makeConstraints {
            $0.top.equalTo(daySelectionView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.contentView.addSubview(timeSelectionView)
        timeSelectionView.snp.makeConstraints {
            $0.top.equalTo(selectTimeLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.contentView.addSubview(expireTimerTitleLabel)
        expireTimerTitleLabel.snp.makeConstraints {
            $0.top.equalTo(timeSelectionView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.contentView.addSubview(expireTimerContainerView)
        self.expireTimerContainerView.snp.makeConstraints{
            $0.height.equalTo(48)
            $0.top.equalTo(expireTimerTitleLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.expireTimerContainerView.addSubview(expireTimerLabel)
        expireTimerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        self.expireTimerContainerView.addSubview(changeExpireTimerButton)
        changeExpireTimerButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
    }
}

extension MakeYakgwaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeCell.identifier, for: indexPath) as? ThemeCell else {
            return UICollectionViewCell()
        }
        
        cell.configure()
        
        return cell
    }
}
