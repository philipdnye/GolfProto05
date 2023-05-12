//
//  CompetitorsScores_Indiv.swift
//  GolfProto05
//
//  Created by Philip Nye on 12/05/2023.
//

import SwiftUI

struct CompetitorsScores_Indiv: View {
    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    @EnvironmentObject var currentGF: CurrentGameFormat
    var holeIndex: Int = 0
    var body: some View {
        ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){competitor in

            ZStack{
                if competitor.competitorScoresArray[holeIndex].scoreCommitted {
                    Text(competitor.competitorScoresArray[holeIndex].grossScore.formatted())
                        .foregroundColor(.blue)
                    
                    if competitor.competitorScoresArray[holeIndex].StablefordPointsNet() != 0 {
                        Text(competitor.competitorScoresArray[holeIndex].StablefordPointsNet().formatted())
                            .foregroundColor(burntOrange)
                            .font(.caption)
                            .offset(x: 10, y: 5)
                    }
                }
            }//ZStack
            
        }//Foreach
    }
}

struct CompetitorsScores_Indiv_Previews: PreviewProvider {
    static var previews: some View {
        CompetitorsScores_Indiv(holeIndex: 0)
            .environmentObject(ScoreEntryViewModel())
            .environmentObject(CurrentGameFormat())
    }
}
