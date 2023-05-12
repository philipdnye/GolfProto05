//
//  TeamScore_forArray.swift
//  GolfProto05
//
//  Created by Philip Nye on 11/05/2023.
//

import SwiftUI

struct TeamScore_forArray: View {
    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    var team: Int = 0
    var holeIndex: Int
    var body: some View {
        
        if scoreEntryVM.currentGame.game.teamScoresArray.filter({$0.team == team})[holeIndex].scoreCommitted {
            Text(scoreEntryVM.currentGame.game.teamScoresArray.filter({$0.team == team})[holeIndex].grossScore.formatted())
                .foregroundColor(.blue)
           // if scoreEntryVM.currentGame.game.teamScoresArray.filter({$0.team == team})[holeIndex].Stable
        }
        
        
        
        
        
        
//        ZStack{
//            if competitor.competitorScoresArray[holeIndex].scoreCommitted {
//                Text(competitor.competitorScoresArray[holeIndex].grossScore.formatted())
//                    .foregroundColor(.blue)
//                if competitor.competitorScoresArray[holeIndex].StablefordPointsNet() != 0 {
//                    Text(competitor.competitorScoresArray[holeIndex].StablefordPointsNet().formatted())
//                        .foregroundColor(burntOrange)
//                        .font(.caption)
//                        .offset(x: 10, y: 5)
//
//                }
//            }
//        }
    }
}

struct TeamScore_forArray_Previews: PreviewProvider {
    static var previews: some View {
        TeamScore_forArray(team: 0, holeIndex: 0)
            .environmentObject(ScoreEntryViewModel())
    }
}



