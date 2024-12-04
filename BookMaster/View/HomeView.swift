//
//  HomeView.swift
//  BookMaster
//
//  Created by Evgeniy Borovoy on 12/4/24.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @State private var currentDate: Date = .init()
    @State private var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = true
    @State private var weekSlider = [[Date.WeekDay]]()
    
    @Namespace private var animation
    @State private var showApproveView: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: - Header
            HeaderView()
            
            // MARK: - Slots
            ScrollView {
                VStack(spacing: 19) {
                    ForEach(Timeslot.mockData) { slot in
                        TimeslotCell(observed: .init(timeslot: slot))
                    }
                }
            }
        }
        .onAppear {
            let currentWeek = Date().fetchWeek()
            if let firstDate = currentWeek.first?.date {
                weekSlider.append(firstDate.createPreviousWeek())
            }
            weekSlider.append(currentWeek)
            
            if let lastDate = currentWeek.last?.date {
                weekSlider.append(lastDate.createNextWeek())
            }
        }
    }
    
    @ViewBuilder func HeaderView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 5) {
                Text(currentDate.format("MMMM"))
                    .foregroundStyle(.bg)
                
                Text(currentDate.format("YYYY"))
                    .foregroundStyle(.black)
            }
            .font(.title.bold())
            
            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self) { index in
                    WeekView(weekSlider[index])
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 100)
        }
            .hSpacing(.leading)
        .padding()
        .background(.white)
        .overlay(alignment: .topTrailing) {
            Image(.img1)
                .resizable()
                .scaledToFit()
                .clipShape(.circle)
                .frame(width: 55)
                .padding()
                .onTapGesture {
                    // TODO: detail view about person
                }
                .overlay {
                    Circle().stroke(.bg, lineWidth: 5)
                        .frame(width: 60)
                }
        }
    }
    
    @ViewBuilder func WeekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0) {
            ForEach(week) { weekDay in
                VStack(spacing: 8) {
                    // week day
                    Text(weekDay.date.format("E"))
                        .font(.callout)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                        .foregroundStyle(isSameDay(weekDay.date, currentDate) ? .black : .gray)
                    
                    // date
                    Text(weekDay.date.format("d"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(isSameDay(weekDay.date, currentDate) ? .black : .gray)
                        .frame(minWidth: 36, minHeight: 36)
                        .background {
                            if isSameDay(weekDay.date, currentDate) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.bg)
                            }
                            
                            if weekDay.date.isToday {
                                Circle()
                                    .fill(.black)
                                    .frame(width: 5, height: 5)
                                    .vSpacing(.bottom)
                                    .offset(y: 10)
                            }
                        }
                }
                .hSpacing(.center)
                .onTapGesture {
                    withAnimation {
                        currentDate = weekDay.date
                    }
                }
            }
        }
        .background {
            GeometryReader { geometry in
                let minX = geometry.frame(in: .global).minX
                
                Color
                    .clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self ) { value in
                        if value.rounded() == 15 && createWeek {
                            paginateWeek()
                        }
                    }
            }
        }
    }
    
    func paginateWeek() {
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
        }
        
        if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == weekSlider.count - 1 {
            weekSlider.append(lastDate.createNextWeek())
            currentWeekIndex = weekSlider.count - 2
        }
    }
}

#Preview {
    HomeView()
}
