//
//  CompetitorsScores_Team.swift
//  GolfProto05
//
//  Created by Philip Nye on 12/05/2023.
//

import SwiftUI

struct CompetitorsScores_Team: View {
    //@EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    var holeIndex:Int = 0
    var teamScoreArray: [TeamScore] = []
    
    var body: some View {
        ZStack{
            if teamScoreArray[holeIndex].scoreCommitted {
                
                Text(teamScoreArray[holeIndex].grossScore.formatted())
                    .foregroundColor(.blue)
                
                if teamScoreArray[holeIndex].StablefordPointsNet() != 0 {
                    Text(teamScoreArray[holeIndex].StablefordPointsNet().formatted())
                        .foregroundColor(burntOrange)
                        .font(.caption)
                        .offset(x: 10, y: 5)
                }
            }
        }
    }
}

struct CompetitorsScores_Team_Previews: PreviewProvider {
    static var previews: some View {
        CompetitorsScores_Team(holeIndex: 0, teamScoreArray: [])
            //.environmentObject(ScoreEntryViewModel())
    }
}
