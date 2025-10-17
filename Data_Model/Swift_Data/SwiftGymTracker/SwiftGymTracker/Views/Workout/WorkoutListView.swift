//
//  WorkoutListview.swift
//  SwiftGymTracker
//
//  Created by D F on 10/17/25.
//


import SwiftUI
import SwiftData

struct WorkoutListView: View {
    @State private var addWorkout = false
    @State private var selectedWorkout: Workout? = nil
    
    var body: some View {
        ContextViewLoader { (vm: WorkoutViewModel) in
            Group {
                let exerciseVM = ExerciseViewModel(context: vm.context)
                VStack{
                    if (vm.items.isEmpty) {
                        VStack {
                            Spacer()
                            Text("No workouts yet. Tap + to create one.")
                                .font(.title3)
                                .italic()
                                .multilineTextAlignment(.center)
                                .padding()
                            Spacer()
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                          
                    }else{
                        List{
                            ForEach(vm.items) { workout in
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text(workout.name)
                                            .fontWeight(.medium)
                                        Spacer()
                                        Text("\(workout.totalVolume.emoji) \(Int(workout.totalVolume)) lb")
                                            .bold()
                                            .foregroundColor(.orange)
                                    }
                                    
                                    Text("Date: \(workout.date.formatted(.dateTime.month().day().year()))")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                    
                                    Text("Exercises: \(workout.safeExercises.count)")
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 5)
                                .contentShape(Rectangle()) // make entire row tappable
                                .onTapGesture {
                                    selectedWorkout = workout
                                }
                                
                            }
                            .onDelete { indexSet in
                                indexSet.forEach { index in
                                    let workout = vm.items[index]
                                    vm.deleteWorkout(workout)
                                }
                            }
                        }
                    }
                }
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addWorkout = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.title2)
                        }
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            let total = vm.totalVolume
                            Text("📊 Total Volume: \(total.emoji) \(Int(total)) lb")
                                .bold()
                                .foregroundColor(.orange)
                        }
                    }
                }
                .navigationTitle("My Workouts")
                .fullScreenCover(isPresented: $addWorkout) {
                    WorkoutFormView()
                        .environment(vm)
                        .environment(exerciseVM)
                }
                .fullScreenCover(item: $selectedWorkout) { workout in
                    WorkoutFormView(workout: workout)
                        .environment(vm)
                        .environment(exerciseVM)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        WorkoutListView()
    }
}

