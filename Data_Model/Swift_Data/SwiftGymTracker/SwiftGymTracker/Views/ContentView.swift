//
//  ContentView.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    enum Tab: String, CaseIterable {
        case exercises = "Exercises"
        case workouts = "Workouts"
    }
    
    @State private var selectedTab: Tab = .exercises
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select Tab", selection: $selectedTab) {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        
                        Text(tab.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Divider()
                
                Spacer()
                
                if selectedTab == .exercises {
                    ExerciseListView()
                }
                
                if selectedTab == .workouts {
                    WorkoutListView()
                }
                
                Spacer()
            }
            .navigationTitle(selectedTab.rawValue)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Exercise.self, Workout.self, configurations: config)
    let context = ModelContext(container)
    
    ContentView()
        .environment(\.modelContext, context)
        .environment(ExerciseViewModel(context: context))
        .environment(WorkoutViewModel(context: context))
}
