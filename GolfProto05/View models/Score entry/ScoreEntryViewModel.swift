//
//  ScoreEntryViewModel.swift
//  GolfProto04
//
//  Created by Philip Nye on 25/04/2023.
//

import Foundation
import SwiftUI


class ScoreEntryViewModel: ObservableObject {
    @StateObject private var gameListVM = GameListViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @Published var holeIndex: Int = 0
    
    @Published var grossScore: Int = 0
    @Published var competitorsScores: [[Int]] = Array(repeating: [0,0,0,0], count: 18)
    @Published var scoresCommitted: [[Bool]] = Array(repeating: [false,false,false,false], count: 18)
    @Published var currentGame: GameViewModel = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
   
    
    @Published var currentMatchScore: Int = 0
    @Published var holesCommitted: Int = 0
    
    
    func assignDefaultValues(currentGF: CurrentGameFormat){
        let manager = CoreDataManager.shared
        let game = manager.getGameById(id: self.currentGame.id)
        for i in 0..<(game?.competitorArray.count ?? 0) {
            for j in 0..<18 {
                let par = Int(game?.SortedCompetitors(currentGF: currentGF)[i].competitorScoresArray[j].par ?? 0)
                let stroke = Int(game?.SortedCompetitors(currentGF: currentGF)[i].competitorScoresArray[j].shotsRecdHoleStroke ?? 0)
                let score = par + stroke
                
                self.competitorsScores[j][i] = score
                self.scoresCommitted[j][i] = false
            }
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    func loadCompetitorsScore(currentGF: CurrentGameFormat) {
        let manager = CoreDataManager.shared
        let game = manager.getGameById(id: self.currentGame.id)
        for i in 0..<(game?.competitorArray.count ?? 0) {
            for j in 0..<18 {
                self.competitorsScores[j][i] = Int(game?.SortedCompetitors(currentGF: currentGF)[i].competitorScoresArray[j].grossScore ?? 0)
                self.scoresCommitted[j][i] = Bool(game?.SortedCompetitors(currentGF: currentGF)[i].competitorScoresArray[j].scoreCommitted ?? false)
            }
        }
        
        
    }
    
    
    
    func saveCompetitorsScore(currentGF: CurrentGameFormat) {
        let manager = CoreDataManager.shared
        let game = manager.getGameById(id: self.currentGame.id)
        
        for i in 0..<(game?.competitorArray.count ?? 0) {
            for j in 0..<18 {
                game?.SortedCompetitors(currentGF: currentGF)[i].competitorScoresArray[j].grossScore = Int16(self.competitorsScores[j][i])
                game?.SortedCompetitors(currentGF: currentGF)[i].competitorScoresArray[j].scoreCommitted = self.scoresCommitted[j][i]
            }
        }
        
        
        
        manager.save()
    }
    
    // similar func for TEAM
    
}


struct HoleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .padding(6)
            .background(burntOrange)
            .foregroundColor(.white)
          
            
    }
}
