//
//  MakeYakgwaViewController.swift
//
//
//  Created by Ekko on 6/3/24.
//

import UIKit
import Combine

import CoreKit
import Util

import ReactorKit
import RxCocoa

public final class MakeYakgwaViewController: UIViewController, View, KeyboardReactable {
    
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    public var cancelBag: Set<AnyCancellable> = Set<AnyCancellable>()
    public weak var coordinator: MakeYakgwaCoordinator?
    
    // MARK: - UI Componenets
    public var scrollView: UIScrollView! = UIScrollView()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .neutral200
        return view
    }()
    
    private lazy var titleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "잡으려는 약속에 대해 알려주세요"
        label.textColor = .neutral700
        label.font = UIFont.m14
        return label
    }()
    
    private lazy var yakgwaTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "약속의 이름이 무엇인가요?"
        label.textColor = .neutralBlack
        label.font = UIFont.m14
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
        textField.textColor = .neutralBlack
        textField.font = UIFont.r14
        
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var textFieldPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "20자 이내로 입력해주세요."
        label.textColor = .neutral500
        label.font = UIFont.r14
        return label
    }()
    
    private lazy var yakgwaTitleTextCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/20"
        label.textColor = .neutral600
        label.font = UIFont.r12
        return label
    }()
    
    private lazy var yakgwaDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "약속에 대해 설명해주세요"
        label.textColor = .neutralBlack
        label.font = UIFont.m14
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
        textView.textColor = .neutralBlack
        textView.font = UIFont.r14
        textView.backgroundColor = .white
        
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var textViewPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "80자 이내로 입력해주세요."
        label.textColor = .neutral500
        label.font = UIFont.r14
        return label
    }()
    
    private lazy var yakgwaDescriptionTextCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/80"
        label.textColor = .neutral600
        label.font = UIFont.r12
        return label
    }()
    
    private lazy var themeLabel: UILabel = {
        let label = UILabel()
        label.text = "어떤 테마의 약속인가요?"
        label.textColor = .neutralBlack
        label.font = UIFont.m14
        return label
    }()
    
    private lazy var themeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.register(ThemeCell.self, forCellWithReuseIdentifier: ThemeCell.identifier)
        
        return collectionView
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "어디에서 모이나요?"
        label.textColor = .neutralBlack
        label.font = UIFont.m14
        return label
    }()
    
    private lazy var locationSubLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 3개 선택 가능"
        label.textColor = .neutral600
        label.font = UIFont.m11
        return label
    }()
    
    private lazy var alreadyLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "이미 장소를 정했어요"
        label.textColor = .neutral700
        label.font = UIFont.m11
        return label
    }()
    
    private lazy var alreadyLocationCheckBox: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "CheckBox", in: .module, with: nil), for: .normal)
        button.setImage(UIImage(named: "CheckedBox", in: .module, with: nil), for: .selected)
        return button
    }()
    
    private lazy var alreadyLocationInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var locationTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .neutralBlack
        textField.font = UIFont.r14
        textField.delegate = self
        return textField
    }()
    
    private lazy var locationPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "지역/지하철역을 검색해주세요."
        label.textColor = .neutral500
        label.font = UIFont.r14
        return label
    }()
    
    private lazy var locationSearchButton: UIButton = {
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
        label.textColor = .neutralBlack
        label.font = UIFont.m14
        return label
    }()
    
    private lazy var alreadyTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "이미 시간을 정했어요"
        label.textColor = .neutral700
        label.font = UIFont.m11
        return label
    }()
    
    private lazy var alreadyTimeCheckBox: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "CheckBox", in: .module, with: nil), for: .normal)
        button.setImage(UIImage(named: "CheckedBox", in: .module, with: nil), for: .selected)
        return button
    }()
    
    private lazy var selectDateLabel: UILabel = {
        let label = UILabel()
        label.text = "투표 가능한 기간을 선택해주세요 (최대 2주)"
        label.textColor = .neutral600
        label.font = UIFont.m11
        return label
    }()
    
    private lazy var daySelectionView: SelectionView = {
        let selectionView = SelectionView(type: .date)
        return selectionView
    }()
    
    private lazy var selectTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "투표 가능한 시간 범위를 선택해주세요"
        label.textColor = .neutral600
        label.font = UIFont.m11
        return label
    }()
    
    private lazy var timeSelectionView: SelectionView = {
        let selectionView = SelectionView(type: .time)
        return selectionView
    }()
    
    private lazy var expireTimerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "초대 마감 시간을 설정해주세요"
        label.textColor = .neutralBlack
        label.font = UIFont.m14
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
        label.textColor = .neutralBlack
        label.font = UIFont.r14
        return label
    }()
    
    private lazy var changeExpireTimerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 14
        button.backgroundColor = .neutral200
        button.setTitle("변경하기", for: .normal)
        button.titleLabel?.font = UIFont.m12
        button.setTitleColor(.neutral800, for: .normal)
        return button
    }()
    
    private lazy var bottomButtonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .neutralWhite
        view.layer.applySketchShadow(color: .neutral600, alpha: 0.2, x: 0, y: -1, blur: 20, spread: 0)
        return view
    }()
    
    private lazy var confirmButton: YakGwaButton = {
        let button = YakGwaButton()
        button.title = "약속 만들기"
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
        
        self.setTapGesture()
        self.setKeyboardNotification()
    }
    
    // MARK: - Binding
    public func bind(reactor: MakeYakgwaReactor) {
        // Action
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppeared }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.yakgwaTitleTextField.rx.text
            .orEmpty
            .map { Reactor.Action.updateTitle($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.yakgwaDescriptionTextView.rx.text
            .orEmpty
            .map { Reactor.Action.updateDescription($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.themeCollectionView.rx.modelSelected(MeetTheme.self)
            .map { Reactor.Action.updateTheme($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Location
        
        
        self.daySelectionView.firstButton.rx.tap
            .map { Reactor.Action.startDateButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.daySelectionView.secondButton.rx.tap
            .map { Reactor.Action.endDateButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.timeSelectionView.firstButton.rx.tap
            .map { Reactor.Action.startTimeButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.timeSelectionView.secondButton.rx.tap
            .map { Reactor.Action.endTimeButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.alreadyLocationCheckBox.rx.tap
            .map { Reactor.Action.alreadySelectedLocationChecked }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.alreadyTimeCheckBox.rx.tap
            .map { Reactor.Action.alreadySelectedDateChecked }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.changeExpireTimerButton.rx.tap
            .map { Reactor.Action.changeExpireDateTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.confirmButton.rx.tap
            .map { Reactor.Action.confirmButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.locationSearchButton.rx.tap
            .withLatestFrom(locationTextField.rx.text.orEmpty)
            .filter { !$0.isEmpty }
            .map { Reactor.Action.addLoaction($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
            
        
        // State
        if #available(iOS 13.4, *) {
            reactor.pulse(\.$isDateViewShow)
                .compactMap { $0 }
                .subscribe(onNext: { [weak self] type in
                    self?.setPickerSheet(type: type)
                })
                .disposed(by: disposeBag)
            
        
        } else {
            // Fallback on earlier versions
        }
        
        reactor.pulse(\.$isExpireHourViewSHow)
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] _ in
                self?.setHourPicker()
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.themes }
            .distinctUntilChanged()
            .bind(to: themeCollectionView.rx.items(cellIdentifier: "ThemeCell", cellType: ThemeCell.self)) { index, theme, cell in
                let isSelected = (reactor.currentState.selectedThemeId == theme.id)
                cell.configure(with: theme, isSelected: isSelected)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.selectedThemeId }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                self?.themeCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.makeMeetComplete ?? 0 }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] meetId in
                // 화면 이동
                if meetId != 0 {
                    self?.coordinator?.moveToYakgwaDetail(with: meetId)
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.yakgwaLocation }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] locations in
                self?.locationStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
                locations.forEach { location in
                    let tagView = LocationTagView(location: location)
                    self?.locationStack.addArrangedSubview(tagView)
                    self?.locationTextField.text = ""
                }
            })
            .disposed(by: disposeBag)
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
        
        self.yakgwaTitleTextField.addSubview(textFieldPlaceholderLabel)
        textFieldPlaceholderLabel.snp.makeConstraints {
            // $0.top.equalTo(yakgwaTitleTextField.snp.top).offset(4)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(yakgwaTitleTextField.snp.leading).offset(8)
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
        
        self.yakgwaDescriptionTextView.addSubview(textViewPlaceholderLabel)
        textViewPlaceholderLabel.snp.makeConstraints {
            $0.top.equalTo(yakgwaDescriptionTextView.snp.top).offset(8)
//            $0.centerY.equalToSuperview()
            $0.leading.equalTo(yakgwaDescriptionTextView.snp.leading).offset(8)
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
            $0.height.equalTo(107)
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
        
        self.alreadyLocationInputContainerView.addSubview(locationTextField)
        locationTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        self.locationTextField.addSubview(locationPlaceholderLabel)
        locationPlaceholderLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(locationTextField.snp.leading).offset(8)
        }
        
        self.alreadyLocationInputContainerView.addSubview(locationSearchButton)
        locationSearchButton.snp.makeConstraints {
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
            $0.bottom.equalToSuperview().offset(-92)
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
            $0.width.equalTo(66)
            $0.height.equalTo(28)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
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
}

extension MakeYakgwaViewController {
    @available(iOS 13.4, *)
    private func setPickerSheet(type: PickerSheetType) {
        let pickerSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        
        switch type {
        case .startDate, .endDate:
            datePicker.datePickerMode = .date
        case .startTime, .endTime:
            datePicker.datePickerMode = .time
            datePicker.minuteInterval = 5
        }
        
        let dateFormatter = DateFormatter()
        
        let doneAction = UIAlertAction(title: "확인", style: .default) { _ in
            switch type {
            case .startDate:
                dateFormatter.dateFormat = "yyyy-MM-dd"
                self.daySelectionView.firstLabel.text = dateFormatter.string(from: datePicker.date)
                self.daySelectionView.firstLabel.textColor = .neutralBlack
                self.reactor?.action.onNext(.updateStartDate(datePicker.date))
            case .endDate:
                dateFormatter.dateFormat = "yyyy-MM-dd"
                self.daySelectionView.secondLabel.text = dateFormatter.string(from: datePicker.date)
                self.daySelectionView.secondLabel.textColor = .neutralBlack
                self.reactor?.action.onNext(.updateEndDate(datePicker.date))
            case .startTime:
                dateFormatter.dateFormat = "HH:mm"
                self.timeSelectionView.firstLabel.text = dateFormatter.string(from: datePicker.date)
                self.timeSelectionView.firstLabel.textColor = .neutralBlack
                self.reactor?.action.onNext(.updateStartTime(datePicker.date))
            case .endTime:
                dateFormatter.dateFormat = "HH:mm"
                self.timeSelectionView.secondLabel.text = dateFormatter.string(from: datePicker.date)
                self.timeSelectionView.secondLabel.textColor = .neutralBlack
                self.reactor?.action.onNext(.updateEndTime(datePicker.date))
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        pickerSheet.addAction(doneAction)
        pickerSheet.addAction(cancelAction)
        
        let vc = UIViewController()
        vc.view = datePicker
        
        pickerSheet.setValue(vc, forKey: "contentViewController")
        
        self.present(pickerSheet, animated: true, completion: nil)
    }
    
    private func setHourPicker() {
        let pickerSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let hourPicker = UIPickerView()
        hourPicker.dataSource = self
        hourPicker.delegate = self
        
        let doneAction = UIAlertAction(title: "확인", style: .default, handler: {_ in
            self.expireTimerLabel.text = "\(hourPicker.selectedRow(inComponent: 0))시간 뒤 초대 마감"
            self.reactor?.action.onNext(.updateExpiredDate(hourPicker.selectedRow(inComponent: 0)))
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        pickerSheet.addAction(doneAction)
        pickerSheet.addAction(cancelAction)
        
        let vc = UIViewController()
        vc.view = hourPicker
        
        pickerSheet.setValue(vc, forKey: "contentViewController")
        
        self.present(pickerSheet, animated: true, completion: nil)
        
    }
    
    
}

extension MakeYakgwaViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width: CGFloat = 96
        return CGSize(width: width, height: height)
    }
}

extension MakeYakgwaViewController: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        // textFieldPlaceholderLabel.isHidden = true
        if textField == yakgwaTitleTextField {
            textFieldPlaceholderLabel.isHidden = true
        } else if textField == locationTextField {
            locationPlaceholderLabel.isHidden = true
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField.text?.isEmpty ?? true {
//            textFieldPlaceholderLabel.isHidden = false
//        }
        if textField == yakgwaTitleTextField {
            if textField.text?.isEmpty ?? true {
                textFieldPlaceholderLabel.isHidden = false
            }
        } else if textField == locationTextField {
            if textField.text?.isEmpty ?? true {
                locationPlaceholderLabel.isHidden = false
            }
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.async {
            // self.textFieldPlaceholderLabel.isHidden = !(textField.text?.isEmpty ?? true)
            if textField == self.yakgwaTitleTextField {
                self.textFieldPlaceholderLabel.isHidden = !(textField.text?.isEmpty ?? true)
            } else if textField == self.locationTextField {
                self.locationPlaceholderLabel.isHidden = !(textField.text?.isEmpty ?? true)
            }
        }
        return true
    }
}

extension MakeYakgwaViewController: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        textViewPlaceholderLabel.isHidden = !textView.text.isEmpty
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        textViewPlaceholderLabel.isHidden = true
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textViewPlaceholderLabel.isHidden = false
        }
    }
}

extension MakeYakgwaViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 24
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)시"
    }
}
