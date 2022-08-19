//
//  NewTemplateView.swift
//  MVCTest
//
//  Created by Ismet Meray on 05/03/2022.
//

import SwiftUI
import SDWebImageSwiftUI
import SwiftfulLoadingIndicators

struct NewTemplateView: View {
    @StateObject var exerciseViewModel: ExerciseViewModel
    @State private var showPopover = false
    @State private var editWorkoutName = false
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 10){
                if(!editWorkoutName){
                    Text(exerciseViewModel.workout?.name ?? "New workout template").font(.title2)
                }else{}
                
                Menu("..."){
                    Button("Edit Workout", action: {})
                    Button("Rename Workout", action: {})
                    Button("Delete Workout", action: {})
                }
                Spacer()
                
                Button(action:{
                    print(exerciseViewModel.workout?.workoutexercise ?? [])
                }){
                    Image(systemName: "checkmark")
                }
            }
            PopOverButton(title: "Add Exercises", showPopOver: $showPopover, exerciseViewModel: exerciseViewModel)
            Divider()
            ScrollView{
                ForEach(exerciseViewModel.workout?.workoutexercise ?? [] , id: \.self) { WorkoutExercise in
                    WorkoutList(workoutExercise: WorkoutExercise)
                }
            }
        }
        .frame(width: 350, alignment: .leading)
        .alert(item: $exerciseViewModel.error) { error in
            Alert(title: Text("An Error Occured"), message: Text(error.localizedDescription))
        }
    }
}

struct PopOverButton: View{
    var title = ""
    @Binding var showPopOver: Bool
    @State var isAnimating: Bool = false
    @ObservedObject var exerciseViewModel: ExerciseViewModel
    @State var searchQuery = ""
    
    var body: some View{
        return Button(action:{
            self.showPopOver = true
        }){
            Text(title)
        }.popover(isPresented: $showPopOver){
            VStack{
                HStack{
                    (Text("Add").fontWeight(.bold).foregroundColor(Color.gray) +
                     Text(" Exercises").foregroundColor(Color.black))
                        .font(.largeTitle)
                    Spacer()
                    
                    if(exerciseViewModel.selectedExercises.count > 0){
                        Button(action:{
                            exerciseViewModel.addExercisesToWorkout()
                            showPopOver = false
                        }){
                            Image(systemName: "checkmark")
                        }
                    }
                }.padding()
                
                HStack(spacing: 20){
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(.gray)
                    
                    TextField("Search for an exercise", text: $searchQuery)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color.primary.opacity(0.05))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
            
            ScrollView{
                LazyVStack(alignment: .leading){
                    ForEach(0..<exerciseViewModel.allExercises.count) { index in
                        Button(action:{
                            //exerciseViewModel.dtoList[index].selected.toggle()
                            if(!exerciseViewModel.selectedExercises.contains(index)){
                                exerciseViewModel.selectExercise(index)
                            }else{
                                exerciseViewModel.deselectExercise(index)
                            }
                        }){
                            Spacer()
                            ExerciseListContent(exerciseViewModel: exerciseViewModel, index: index)
                            Spacer()
                        }
                        .background(exerciseViewModel.selectedExercises.contains(index) ? Color.gray : Color.clear)
                    }
                }
                Spacer()
            }
        }
    }
}

struct NewTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        let exerciseVM: ExerciseViewModel = ExerciseViewModel()
        
        NewTemplateView(exerciseViewModel: exerciseVM).onAppear(perform: exerciseVM.loadInAllExercises)
    }
}


struct ExerciseListContent : View{
    @ObservedObject var exerciseViewModel: ExerciseViewModel
    var index: Int
    var body: some View{
        return HStack(spacing: 10){
            //exerciseViewModel.dtoList[index].exercise.gifURL
            
            let url: String = "https://res.cloudinary.com/hollistichabbits/image/upload/v1659619186/gifs/" + exerciseViewModel.allExercises[index].gifURL + ".png.gif"
            
            AsyncImage(url: URL(string: url)) { image in
                image.resizable()
            } placeholder: {
                LoadingIndicator(animation: .fiveLines, color: .red)
            }
            .frame(width: 75, height: 75)
            .clipShape(RoundedRectangle(cornerRadius: 25))
        
            
            Text(exerciseViewModel.allExercises[index].name)
                .foregroundColor(Color.black)
                .frame(width: 150 ,alignment: .center)
            
            Spacer()
            Image(systemName: exerciseViewModel.selectedExercises.contains(index) ? "checkmark.square.fill" : "square")
                .frame(alignment: .trailing)
            Spacer()
        }
    }
}


struct WorkoutList : View{
    
    var workoutExercise: WorkoutExercise
    @State var setText = ""
    var body: some View{
        return VStack(alignment: .leading){
            //exerciseViewModel.dtoList[index].exercise.gifURL
            HStack(spacing: 10){
                Text(workoutExercise.exercise.name)
                .foregroundColor(Color.gray)
                .frame(width: .infinity ,alignment: .center)
                .font(.title2)
                
                Spacer()
                
                Text("...")
                    .frame(alignment: .trailing)
            }
            
            HStack{
                Text("Set")
                Spacer()
                Text("Previous").frame(alignment: .leading)
                Spacer()
                Text("kg")
                Spacer()
                Text("Reps")
                Spacer()
                Image(systemName: "checkmark")
                
            }
            //for loop for sets
            Spacer()
            
            ForEach(workoutExercise.exerciseData, id: \.self){
                data in
                HStack(alignment: .lastTextBaseline){
                    Text("1")
                    Spacer()
                    Text("20 kg x 20")
                    Spacer()
                    Text("20")
                    Spacer()
                    Text("20")
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
            
            Divider()
            Spacer()
            
        }.frame(width: 350, height: 100, alignment: .leading)
    }
}


//                                AnimatedImage(url: URL(string: exerciseViewModel.dtoList[index].exercise.gifURL), isAnimating: $isAnimating)
//                                    .maxBufferSize(.max)
//                                    .resizable()
//                                    .frame(width: 100, height: 100, alignment: .leading)
//


//                                WebImage(url: URL(string: exerciseViewModel.dtoList[index].exercise.gifURL))
//                                    .onSuccess(){
//                                        image, data, cacheType in
//                                    }
//                                    .placeholder(Image("UserImage"))
//                                    .resizable()
//                                    .renderingMode(.original)
//                                    .scaledToFit()
//                                    .frame(width: 100, height: 100, alignment: .leading)
