//
//  CalendarVoteViewController.swift
//
//
//  Created by Ekko on 6/6/24.
//

import UIKit
import SnapKit
import ReactorKit
import RxCocoa

public final class CalendarVoteViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    public var coordinator: CalendarVoteCoordinator?
    
    private var dates: [Date] = []
    private var timeSlots: [String] = []
    var startDate: Date?
    var endDate: Date?
    var startTime: Date?
    var endTime: Date?
    
    // MARK: - UI Components
    private lazy var dateCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 40)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .neutralWhite
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: "DateCell")
        collectionView.register(WeekdayHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WeekdayHeaderView.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var timeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(TimeSlotCell.self, forCellWithReuseIdentifier: "TimeSlotCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return collectionView
    }()
    
    private lazy var calendarContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .neutralWhite
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var timeTableContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .neutralWhite
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var calendarTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "2024년 6월"
        label.font = .sb16
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var timeTableDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2024/05/14"
        label.font = .m14
        label.textColor = .neutralBlack
        return label
    }()
    
    private lazy var participantLabel: UILabel = {
        let label = UILabel()
        label.text = "3명 참여 >"
        label.font = .m11
        label.textColor = .neutral600
        return label
    }()
    
    // MARK: - Initializers
    public init(reactor: CalendarVoteReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
        // self.setupDate()
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
        self.view.backgroundColor = .neutral200
        
        self.view.addSubview(calendarContainer)
        calendarContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        
        calendarContainer.addSubview(calendarTitleLabel)
        calendarTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        calendarContainer.addSubview(participantLabel)
        participantLabel.snp.makeConstraints {
            $0.centerY.equalTo(calendarTitleLabel)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        calendarContainer.addSubview(dateCollectionView)
        dateCollectionView.snp.makeConstraints {
            $0.top.equalTo(calendarTitleLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.height.equalTo(188)
            $0.leading.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        self.view.addSubview(timeTableContainer)
        timeTableContainer.snp.makeConstraints {
            $0.top.equalTo(calendarContainer.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
        timeTableContainer.addSubview(timeTableDateLabel)
        timeTableDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        timeTableContainer.addSubview(timeCollectionView)
        timeCollectionView.snp.makeConstraints {
            $0.top.equalTo(timeTableDateLabel.snp.bottom).offset(16)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Binding
    public func bind(reactor: CalendarVoteReactor) {
        // Action
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppeared }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        dateCollectionView.rx.itemSelected
            .map { [weak self] indexPath -> Reactor.Action in
                guard let self = self else { return Reactor.Action.dateSelected(Date()) }
                let selectedDate = self.dates[indexPath.item + 1]
                return Reactor.Action.dateSelected(selectedDate)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.showDateTimePicker }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] date in
                guard let self = self else { return }
                if let date = date {
                    print("\(date)")
                }
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.fetchedDate }
            .subscribe(onNext: { [weak self] dates in
                guard let self = self else { return }
                if let dates = dates {
                    self.startDate = dates.startDate
                    self.endDate = dates.endDate
                    self.dates = self.generateCalendarDates(startDate: dates.startDate, endDate: dates.endDate)
                    self.dateCollectionView.reloadData()
                }
            }).disposed(by: disposeBag)
        
        reactor.state.map { $0.fetchedTime }
            .subscribe(onNext: { [weak self] timeRange in
                guard let self = self else { return }
                if let timeRange = timeRange {
                    self.startTime = timeRange.startTime
                    self.endTime = timeRange.endTime
                    self.timeSlots = self.generateHourlyTimeSlots(from: timeRange.startTime, to: timeRange.endTime)
                    self.timeCollectionView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
}

// MARK: - Privates
extension CalendarVoteViewController {
    
    private func generateCalendarDates(startDate: Date, endDate: Date) -> [Date] {
        let calendar = Calendar.current
        
        // startDate의 요일을 가져오기 (일요일: 1, 월요일: 2, ...)
        let weekday = calendar.component(.weekday, from: startDate)
        
        // startDate에서 일요일까지의 차이 계산
        let daysToSunday = (weekday - calendar.firstWeekday + 7) % 7
        
        // startDate를 포함한 그 주의 일요일을 계산
        guard let firstSunday = calendar.date(byAdding: .day, value: -daysToSunday, to: startDate) else {
            return []
        }
        
        // 시작 일요일부터 날짜 생성
        var dates = [Date]()
        for i in -7..<14 {
            if let date = calendar.date(byAdding: .day, value: i, to: firstSunday) {
                dates.append(date)
            }
        }
        
        return dates
    }
    
    private func generateHourlyTimeSlots(from startTime: Date, to endTime: Date) -> [String] {
        var slots: [String] = []
        let calendar = Calendar.current
        var currentTime = calendar.date(bySettingHour: calendar.component(.hour, from: startTime), minute: 0, second: 0, of: startTime)!
        
        while currentTime < endTime {
            let nextHour = calendar.date(byAdding: .hour, value: 1, to: currentTime)!
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH"
            let slot = "\(timeFormatter.string(from: currentTime))시"
            slots.append(slot)
            currentTime = nextHour
        }
        
        return slots
    }

}

extension CalendarVoteViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dateCollectionView {
            return dates.count
        } else {
            return timeSlots.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dateCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
            let date = dates[indexPath.item]
            let formatter = DateFormatter()
            formatter.dateFormat = "d"
            cell.dateLabel.text = formatter.string(from: date)
            
            if date >= startDate! && date <= endDate! { // TODO: - Optinal Binding
                cell.dateLabel.textColor = .orange
                cell.contentView.backgroundColor = .white
            } else {
                cell.dateLabel.textColor = .neutralBlack
                cell.contentView.backgroundColor = .white
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeSlotCell", for: indexPath) as! TimeSlotCell
            let date = timeSlots[indexPath.item]
            cell.timeLabel.text = date
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == dateCollectionView {
            let width = collectionView.frame.width / 7
            return CGSize(width: width, height: width)
        } else {
            let width = collectionView.frame.width / 7
            return CGSize(width: 52, height: 50)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader && collectionView == dateCollectionView {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WeekdayHeaderView.reuseIdentifier, for: indexPath) as! WeekdayHeaderView
            return headerView
        }
        return UICollectionReusableView()
    }
}
