//
//  CalendarVoteViewController.swift
//
//
//  Created by Ekko on 6/6/24.
//

import UIKit

import CoreKit
import Util

import ReactorKit
import RxCocoa

public final class CalendarVoteViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    public var coordinator: CalendarVoteCoordinator?
    
    private var dates: [Date] = []
    var startDate: Date?
    var endDate: Date?
    
    // MARK: - UI Components
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 40)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: "DateCell")
        collectionView.register(WeekdayHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WeekdayHeaderView.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var calendarContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .neutralWhite
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var calendarTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "2024년 5월"
        label.font = .sb16
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
        self.setupDate()
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
        
        calendarContainer.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(calendarTitleLabel.snp.bottom).offset(16)
            $0.height.equalTo(188)
            $0.leading.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-24)
        }
        
    }
    // MARK: - Binding
    public func bind(reactor: CalendarVoteReactor) {
        
    }
}

// MARK: - Privates
extension CalendarVoteViewController {
    private func setupDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let start = dateFormatter.date(from: "2024-05-14"),
              let end = dateFormatter.date(from: "2024-05-16") else {
            fatalError("Invalid date format")
        }
        self.startDate = start
        self.endDate = end
        self.dates = generateCalendarDates(startDate: start, endDate: end)
    }
    
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
}

extension CalendarVoteViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: width)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WeekdayHeaderView.reuseIdentifier, for: indexPath) as! WeekdayHeaderView
            return headerView
        }
        return UICollectionReusableView()
    }
}
