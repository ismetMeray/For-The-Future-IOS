//
//  HomePage.swift
//  MVCTest
//
//  Created by Ismet Meray on 31/01/2022.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var viewModel: HomePageViewModel
    @State var show = false
    @State var message = "Good luck!"
    @State var c: AlertAction?
    @State var selection: Int? = nil
    @State private var savedWorkout = false
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView{
            ScrollView{
                    ZStack(){
                        VStack{
                            HStack{
                                NewNavigationButton(message: "New Workout Template", destination: NewTemplateView(exerciseViewModel: ExerciseViewModel(), savedWorkout: $savedWorkout))
                                
                                NewNavigationButton(message: "new Empty workout", destination: EmptyWorkoutView().body)
                            }
                            if viewModel.user.workOuts.capacity > 0{
                                LazyVGrid(columns: twoColumnGrid){
                                    ForEach(self.viewModel.user.workOuts, id: \.id){ currentWorkout in
                                        ProductCard(workOut: currentWorkout, show: $show)
                                    }
                                }
                            }else{
                                Text("No Workout available")
                            }
                        }
                        if show{
                            AlertView(shown: $show, closureA: $c, message: message).frame(alignment: .top)
                        }else if savedWorkout{
                            AlertView(shown: $savedWorkout, closureA: $c, message: "saved workout").frame(alignment: .top)
                        }
                }
            }.navigationBarTitle("Start A New Workout")
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Error"), message: Text(error.localizedDescription))
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var viewModel: HomePageViewModel = HomePageViewModel()
    
    static var previews: some View {
        HomePage().environmentObject(viewModel)
    }
}

private struct NewToolBarItemHP : ToolbarContent{
    var body: some ToolbarContent{
        return ToolbarItem(placement: .automatic){
            Button(action: {
                print("action triggered")
            }){
                Text("Settings").padding()
            }.buttonStyle(PlainButtonStyle())
                .background(Color(UIColor.black))
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct ProductCard: View {
    
    var workOut: Workout
    var allExerciseNames = ""
    @Binding var show: Bool
     
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Button(action: {
                show.toggle()
            }){
                VStack(alignment: .leading) {
                    Spacer()
                    Text(self.workOut.name).multilineTextAlignment(.center)
                        .font(.system(size: 20, weight: .heavy, design: .default))
                        .foregroundColor(.white)
                    Spacer()
                    ForEach(workOut.workoutexercise, id: \.order){ currentExercise in
                        if(currentExercise.order <= 3){
                            Text(currentExercise.exercise.name).foregroundColor(.white)
                                .frame(width: 100, height: 25, alignment: .leading)
                        }
                    }
                    Spacer()
                    Text("Last Used:")
                        .frame(minWidth: 100, minHeight: 5, maxHeight: .infinity, alignment: .bottomLeading)
                }
                .fixedSize(horizontal: true, vertical: true)
                .frame(minWidth: 75, minHeight: 210, alignment: .top)
            }
            WorkoutPopUp()
        }
        .listRowBackground(Color.clear)
        .frame(maxWidth: 175, maxHeight: .infinity, alignment: .center)
        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
        .modifier(CardModifier())
        
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}

struct WorkoutPopUp: View{
    var body: some View{
        Menu("..."){
            Button("Edit Workout", action: {})
            Button("Rename Workout", action: {})
            Button("Delete Workout", action: {})
        }
        .frame(alignment: .trailing)
    }
    
}
