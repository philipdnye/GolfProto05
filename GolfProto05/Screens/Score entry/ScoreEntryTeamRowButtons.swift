//
//  ScoreEntryTeamRowButtons.swift
//  GolfProto05
//
//  Created by Philip Nye on 10/05/2023.
//

import SwiftUI

struct ScoreEntryTeamRowButtons: View {
    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    var teamIndex: Int
    var body: some View {
        HStack(spacing:25){
            Button(action: {
          
                scoreEntryVM.teamsScores[scoreEntryVM.holeIndex][teamIndex] -= 1
                scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][teamIndex] = true
                scoreEntryVM.saveCompetitorsScoreTeam()
            }) {
                Image(systemName: "minus.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(gold)
            }
           
            
//
            switch scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][teamIndex] {// changes the opacity of the font depending on whther the score has been committed
            case false:
                TeamRowScoreBox(teamIndex: teamIndex, opacity: 0.5)
                
//
            case true:
                TeamRowScoreBox(teamIndex: teamIndex, opacity: 1.0)
            }
            
            Button(action: {
               
                scoreEntryVM.teamsScores[scoreEntryVM.holeIndex][teamIndex] += 1
                scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][teamIndex] = true
                scoreEntryVM.saveCompetitorsScoreTeam()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(gold)
            }
        }
    }
}

struct ScoreEntryTeamRowButtons_Previews: PreviewProvider {
    static var previews: some View {
        ScoreEntryTeamRowButtons(teamIndex: 0)
            .environmentObject(ScoreEntryViewModel())
    }
}
