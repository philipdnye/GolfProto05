//
//  ScoreEntryCompetitorRow.swift
//  GolfProto04
//
//  Created by Philip Nye on 26/04/2023.
//

import SwiftUI

struct ScoreEntryCompetitorRow: View {
   
    var competitorIndex: Int
    

    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    @EnvironmentObject var currentGF: CurrentGameFormat
    @Binding var needsRefresh: Bool
    var body: some View {
        
        HStack(spacing:0){
            HStack(spacing: 5){
                
                
              
                
                //Text(scoreEntryVM.currentGame.game.competitorArray[competitorIndex].FirstName())
               // Text(scoreEntryVM.currentGame.game.competitorArray[competitorIndex].LastName().prefix(1).capitalized)
                
                Text(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF)[competitorIndex].FirstName())
                Text(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF)[competitorIndex].LastName().prefix(1).capitalized)
                
                
                
                
            }
            .font(.title)
            .font(.footnote.weight(.semibold))
            .foregroundColor(darkTeal)
            //                .frame(width: geo.size.width * 0.4, height: 75,alignment: .leading)
            .padding([.leading],10)
            
            Spacer()
       
            HStack(spacing:25){
                Button(action: {
                    scoreEntryVM.competitorsScores[scoreEntryVM.holeIndex][competitorIndex] -= 1
                    scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][competitorIndex] = true
                    scoreEntryVM.saveCompetitorsScore(currentGF: currentGF)
                    needsRefresh.toggle()
//
                }) {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(gold)
                }
                //.disabled(score < 1)
                
//
                switch scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][competitorIndex] {// changes the opacity of the font depending on whther the score has been committed
                case false:
                    CompetitorRowScoreBox(competitorIndex: competitorIndex, opacity: 0.5, needsRefresh: $needsRefresh)
                    
//
                case true:
                    CompetitorRowScoreBox(competitorIndex: competitorIndex, opacity: 1.0, needsRefresh: $needsRefresh)
                }
                
                Button(action: {
                    scoreEntryVM.competitorsScores[scoreEntryVM.holeIndex][competitorIndex] += 1
                    scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][competitorIndex] = true
                    scoreEntryVM.saveCompetitorsScore(currentGF: currentGF)
                    needsRefresh.toggle()

                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(gold)
                }
            }

        }
//        .onAppear(perform: {
//
//        })
        
    }
}
struct ScoreEntryCompetitorRow_Previews: PreviewProvider {
    static var previews: some View {
        ScoreEntryCompetitorRow(competitorIndex: 0, needsRefresh: .constant(false))
            .environmentObject(ScoreEntryViewModel())
            .environmentObject(CurrentGameFormat())
            
    }
}
