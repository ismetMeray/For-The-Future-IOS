//
//  ExerciseSelection.swift
//  MVCTest
//
//  Created by Ismet Meray on 12/03/2022.
//

import Foundation

struct ExerciseSelection{
    
    var exercise: Exercise
    var selected: Bool

    init(_ exericse: Exercise, _ selected: Bool){
        self.exercise = exericse
        self.selected = selected
    }
}
