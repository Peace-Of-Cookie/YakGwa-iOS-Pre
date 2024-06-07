//
//  PostVoteSchedulesRequestDTO.swift
//
//
//  Created by Ekko on 6/7/24.
//

import Foundation
/*
 {
   "possibleSchedules": [
     {
       "possibleStartTime": "2024-06-07T06:12:15.283Z",
       "possibleEndTime": "2024-06-07T06:12:15.283Z"
     }
   ]
 }
 */
public struct PostVoteSchedulesRequestDTO: Codable, Equatable {
    public let possibleSchedules: [PossibleScheduleDTO]
    
    public struct PossibleScheduleDTO: Codable, Equatable {
        public let possibleStartTime: String
        public let possibleEndTime: String
    }
    
    public init(selectedTimes: [Date: [String]]) {
        var schedules: [PossibleScheduleDTO] = []
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        let calendar = Calendar.current
        
        for (date, times) in selectedTimes {
            for time in times {
                if let startHour = Int(time.replacingOccurrences(of: "시", with: "")) {
                    var modifiedDate = calendar.date(byAdding: .day, value: 1, to: date)!
                    modifiedDate = calendar.startOfDay(for: modifiedDate)
                    
                    let startDate = calendar.date(bySettingHour: startHour, minute: 0, second: 0, of: modifiedDate)!
                    let endDate = calendar.date(byAdding: .hour, value: 1, to: startDate)!
                    
                    let possibleStartTime = dateFormatter.string(from: startDate)
                    let possibleEndTime = dateFormatter.string(from: endDate)
                    
                    let schedule = PossibleScheduleDTO(possibleStartTime: possibleStartTime, possibleEndTime: possibleEndTime)
                    schedules.append(schedule)
                }
            }
        }
        
        self.possibleSchedules = schedules
    }
}
