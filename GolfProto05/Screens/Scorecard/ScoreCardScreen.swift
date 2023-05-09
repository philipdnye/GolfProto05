//
//  ScoreCardScreen.swift
//  GolfProto04
//
//  Created by Philip Nye on 27/04/2023.
//

import SwiftUI

struct ScorecardScreen: View {
    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    @EnvironmentObject var currentGF: CurrentGameFormat
    
    var body: some View {
      
        
        GeometryReader{geo in
            
            
            List{
//                HStack{
//                    Text(scoreEntryVM.currentGame.game.FourBallBetterBallNetResult()[0])
//                    Text(scoreEntryVM.currentGame.game.FourBallBetterBallNetResult()[1])
//                    Text(scoreEntryVM.currentGame.game.FourBallBetterBallNetResult()[2])
//                }
                
                
                
                HStack(spacing: 0){
                    Group{
                        ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self) {
                            Text($0.player?.Initials() ?? "")
                        }
                    }
                    .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                }
                .offset(x: geo.size.width * 0.31)
                .foregroundColor(darkTeal)
                .fontWeight(.semibold)
                
                let front9Holes = Array(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray ?? []).prefix(9)
                
                
                
                ForEach(0..<front9Holes.count, id: \.self) {holeIndex in
                    HStack(spacing:0){
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].number.formatted() ?? "")
                        Text(Int(front9Holes[holeIndex].number).formatted())
                            .frame(width: geo.size.width * 0.06, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].distance.formatted() ?? "")
                        Text(Int(front9Holes[holeIndex].distance).formatted())
                            .frame(width: geo.size.width * 0.1, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].par.formatted() ?? "")
                        Text(Int(front9Holes[holeIndex].par).formatted())
                            .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].strokeIndex.formatted() ?? "")
                        Text(Int(front9Holes[holeIndex].strokeIndex).formatted())
                            .frame(width: geo.size.width * 0.075, height: geo.size.height * 0.03)
                            .foregroundColor(burntOrange)
                        
                        
                        HStack(spacing:0){
                            Group{
                                    
                                ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){
                                  
                                    CompetitorScore_forArray(competitor: $0,holeIndex: holeIndex)
                                    
                                    
                                }
                            }
                           // .foregroundColor(.blue)
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                            .offset(x: geo.size.width * 0.026)
                        }
                    }
                }//foreach
               
                
                
                HStack(spacing:0){
                    //hole summary front 9
                    HStack(spacing:0){
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_front9.TotalDistance() ?? 0))
                            .frame(width:geo.size.width * 0.15)
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_front9.TotalPar() ?? 0))
                            .frame(width:geo.size.width * 0.065)
                    }
                    .foregroundColor(darkTeal)
                    .fontWeight(.semibold)
                    
                    
                    
                    
                    // players front 9 totals
                    HStack(spacing: 0){
                        Group{
                            ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){
                                
                                
                                
                                    if $0.competitorScoresArray.TotalGrossScore_front9() != 0 {
                                        //ZStack{
                                        
                                        CompetitorScores(competitor: $0, grossTotal: $0.competitorScoresArray.TotalGrossScore_front9(), pointsTotal: $0.competitorScoresArray.TotalStablefordPoints_front9())
                                            
                                        
                                    }
                                    // }
                                    
                                
                                
                                
                            }
                            
//                            ForEach(totalscores, id:\.self){score in
//                                Text(score.formatted())
//                            }
                        }
                        .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                    }
                    .offset(x: geo.size.width * 0.095)
                    
                    .fontWeight(.semibold)
                    
                }
                
                let back9Holes = Array(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray ?? []).suffix(9)
                
                ForEach(0..<back9Holes.count, id: \.self) {holeIndex in
                    HStack(spacing:0){
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].number.formatted() ?? "")
                        Text(Int(back9Holes[holeIndex + 9].number).formatted())
                            .frame(width: geo.size.width * 0.06, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].distance.formatted() ?? "")
                        Text(Int(back9Holes[holeIndex + 9].distance).formatted())
                            .frame(width: geo.size.width * 0.1, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].par.formatted() ?? "")
                        Text(Int(back9Holes[holeIndex + 9].par).formatted())
                            .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].strokeIndex.formatted() ?? "")
                        Text(Int(back9Holes[holeIndex + 9].strokeIndex).formatted())
                            .frame(width: geo.size.width * 0.075, height: geo.size.height * 0.03)
                            .foregroundColor(burntOrange)
                        
                        HStack(spacing:0){
                            Group{
                                ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){
                                  
                                    CompetitorScore_forArray(competitor: $0,holeIndex: holeIndex + 9)
                                    
                                    
                                }
                            }
                            .foregroundColor(.blue)
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                            .offset(x: geo.size.width * 0.026)
                        }
                        
                        
                        
                        
                        
                        
                    }
                }
                
                // hole back 9 totals
                HStack(spacing:0){
                    //hole summary front 9
                    HStack(spacing:0){
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_back9.TotalDistance() ?? 0))
                            .frame(width:geo.size.width * 0.15)
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_back9.TotalPar() ?? 0))
                            .frame(width:geo.size.width * 0.065)
                    }
                    .foregroundColor(darkTeal)
                    .fontWeight(.semibold)
                    
                    
                    
                    
                    // players back 9 totals
                    HStack(spacing: 0){
                        Group{
                            ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){
                                if $0.competitorScoresArray.TotalGrossScore_back9() != 0 {
                                    Text($0.competitorScoresArray.TotalGrossScore_back9().formatted())
                                }
                            }
                        }
                        .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                    }
                    .offset(x: geo.size.width * 0.095)
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                    
                }
                
                // players front 9 totals
                HStack(spacing:0){
                    //hole summary front 9
                    HStack(spacing:0){
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_front9.TotalDistance() ?? 0))
                            .frame(width:geo.size.width * 0.15)
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray_front9.TotalPar() ?? 0))
                            .frame(width:geo.size.width * 0.065)
                    }
                    .foregroundColor(darkTeal)
                    .fontWeight(.semibold)
                    
                    
                    
                    
                    // players fromt 9 totals
                    HStack(spacing: 0){
                        Group{
                            ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){
                                if $0.competitorScoresArray.TotalGrossScore_front9() != 0 {
                                    Text($0.competitorScoresArray.TotalGrossScore_front9().formatted())
                                }
                            }
                        }
                        .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                    }
                    .offset(x: geo.size.width * 0.095)
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                    
                }
                
                // players  totals
                HStack(spacing:0){
                    //hole summary overall
                    HStack(spacing:0){
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.TotalDistance() ?? 0))
                            .frame(width:geo.size.width * 0.15)
                        Text (String(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.TotalPar() ?? 0))
                            .frame(width:geo.size.width * 0.065)
                    }
                    .foregroundColor(darkTeal)
                    .fontWeight(.semibold)
                    
                    
                    
                    
                    // players overall totals
                    HStack(spacing: 0){
                        Group{
                            ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){
                                if $0.competitorScoresArray.TotalGrossScore() != 0 {
                                    Text($0.competitorScoresArray.TotalGrossScore().formatted())
                                }
                            }
                        }
                        .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                    }
                    .offset(x: geo.size.width * 0.095)
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                    
                }
                
                
                
                HStack(spacing: 0){
                    Group{
                        ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self) {
                            Text($0.player?.Initials() ?? "")
                        }
                           
                    }
                    .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                }
                .offset(x: geo.size.width * 0.31)
                .foregroundColor(darkTeal)
                .fontWeight(.semibold)
                
            }
            
            
        }
    }
}

struct ScorecardScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        ScorecardScreen()
            .environmentObject(ScoreEntryViewModel())
            .environmentObject(CurrentGameFormat())
    }
}
