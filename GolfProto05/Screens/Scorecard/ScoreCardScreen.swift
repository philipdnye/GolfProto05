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
                       
                        Text(Int(front9Holes[holeIndex].number).formatted())
                            .frame(width: geo.size.width * 0.06, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        
                        Text(Int(front9Holes[holeIndex].distance).formatted())
                            .frame(width: geo.size.width * 0.1, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        
                        Text(Int(front9Holes[holeIndex].par).formatted())
                            .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                       
                        Text(Int(front9Holes[holeIndex].strokeIndex).formatted())
                            .frame(width: geo.size.width * 0.075, height: geo.size.height * 0.03)
                            .foregroundColor(burntOrange)
                        
                        //******SWITCH HERE********
                        
                        switch currentGF.assignShotsRecd {
                            
                        case .Indiv:
                            
                            
                            HStack(spacing:0){
                                Group{
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
                                        
                                    }
                                }
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                                .offset(x: geo.size.width * 0.026)
                            }
                        case .TeamsAB:
                            
                            HStack(spacing:geo.size.width * 0.048){
                                Spacer()
                                    .frame(width: geo.size.width * 0.011)
                                Group{
                                    
                                    ZStack{
                                        if scoreEntryVM.currentGame.game.teamAScoresArray[holeIndex].scoreCommitted {
                                            
                                            Text(scoreEntryVM.currentGame.game.teamAScoresArray[holeIndex].grossScore.formatted())
                                                .foregroundColor(.blue)
                                            
                                            if scoreEntryVM.currentGame.game.teamAScoresArray[holeIndex].StablefordPointsNet() != 0 {
                                                Text(scoreEntryVM.currentGame.game.teamAScoresArray[holeIndex].StablefordPointsNet().formatted())
                                                    .foregroundColor(burntOrange)
                                                    .font(.caption)
                                                    .offset(x: 10, y: 5)
                                            }
                                        }
                                    }
                                    
                                    ZStack{
                                        if scoreEntryVM.currentGame.game.teamBScoresArray[holeIndex].scoreCommitted {
                                            
                                            Text(scoreEntryVM.currentGame.game.teamBScoresArray[holeIndex].grossScore.formatted())
                                                .foregroundColor(.blue)
                                            
                                            if scoreEntryVM.currentGame.game.teamBScoresArray[holeIndex].StablefordPointsNet() != 0 {
                                                Text(scoreEntryVM.currentGame.game.teamBScoresArray[holeIndex].StablefordPointsNet().formatted())
                                                    .foregroundColor(burntOrange)
                                                    .font(.caption)
                                                    .offset(x: 10, y: 5)
                                            }
                                        }
                                    }
                                    

                                    
                                }
                                
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                                .offset(x: geo.size.width * 0.026)
                                
                            }
                            
                       
                        case .TeamC:
                            HStack(spacing:geo.size.width * 0.048){
                                Spacer()
                                    .frame(width: geo.size.width * 0.011)
                                Group{
                                    
                                    ZStack{
                                        if scoreEntryVM.currentGame.game.teamCScoresArray[holeIndex].scoreCommitted {
                                            
                                            Text(scoreEntryVM.currentGame.game.teamCScoresArray[holeIndex].grossScore.formatted())
                                                .foregroundColor(.blue)
                                            
                                            if scoreEntryVM.currentGame.game.teamCScoresArray[holeIndex].StablefordPointsNet() != 0 {
                                                Text(scoreEntryVM.currentGame.game.teamCScoresArray[holeIndex].StablefordPointsNet().formatted())
                                                    .foregroundColor(burntOrange)
                                                    .font(.caption)
                                                    .offset(x: 10, y: 5)
                                            }
                                        }
                                    }
                                    
                                   
                                }
                                
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                                .offset(x: geo.size.width * 0.026)
                                
                            }
                            
                            
                        }//switch
                            
                        //***********************
                    
                        
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
                    
                    // SWITCH HERE*************************
                    switch currentGF.assignShotsRecd{
                    case .Indiv:
                        HStack(spacing: 0){
                            Group{
                                ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){ competitor in
                                    
                                    if competitor.competitorScoresArray.TotalGrossScore_front9() != 0 {
                                        ZStack{
                                            Text(competitor.competitorScoresArray.TotalGrossScore_front9().formatted())
                                                .foregroundColor(.blue)
                                            Text(competitor.competitorScoresArray.TotalStablefordPoints_front9().formatted())
                                                .foregroundColor(burntOrange)
                                                .font(.caption)
                                                .offset(x: 15, y: 10)
                                            //CompetitorScores(competitor: $0, grossTotal: $0.competitorScoresArray.TotalGrossScore_front9(), pointsTotal: $0.competitorScoresArray.TotalStablefordPoints_front9())
                                        }
                                    }
                                    
                                }
                                
                            }//Group
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                        }//HStack
                        
                        .offset(x: geo.size.width * 0.095)
                        
                        .fontWeight(.semibold)
                    case .TeamsAB:
                        EmptyView()//placeholder
                    case .TeamC:
                        EmptyView()//placeholder
                        
                    }//switch
                    
                }//totals HStack
                
                let back9Holes = Array(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray ?? []).suffix(9)
                
                ForEach(0..<back9Holes.count, id: \.self) {holeIndex in
                    HStack(spacing:0){
                       
                        Text(Int(back9Holes[holeIndex + 9].number).formatted())
                            .frame(width: geo.size.width * 0.06, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                       
                        Text(Int(back9Holes[holeIndex + 9].distance).formatted())
                            .frame(width: geo.size.width * 0.1, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                       
                        Text(Int(back9Holes[holeIndex + 9].par).formatted())
                            .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        
                        Text(Int(back9Holes[holeIndex + 9].strokeIndex).formatted())
                            .frame(width: geo.size.width * 0.075, height: geo.size.height * 0.03)
                            .foregroundColor(burntOrange)
                        
                        
                        //***************SWITCH HERE************************
                       
                        switch currentGF.assignShotsRecd {
                            
                        case .Indiv:
                        
                            HStack(spacing:0){
                                Group{
                                    ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){competitor in
                                        
                                        ZStack{
                                            if competitor.competitorScoresArray[holeIndex+9].scoreCommitted {
                                                Text(competitor.competitorScoresArray[holeIndex+9].grossScore.formatted())
                                                    .foregroundColor(.blue)
                                                
                                                if competitor.competitorScoresArray[holeIndex+9].StablefordPointsNet() != 0 {
                                                    Text(competitor.competitorScoresArray[holeIndex+9].StablefordPointsNet().formatted())
                                                        .foregroundColor(burntOrange)
                                                        .font(.caption)
                                                        .offset(x: 10, y: 5)
                                                }
                                            }
                                        }//ZStack
                                        
                                        
                                    }
                                }
                                .foregroundColor(.blue)
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                                .offset(x: geo.size.width * 0.026)
                            }
                            
                        case .TeamsAB:
                           
                            HStack(spacing:0){
                                Group{
                                    ZStack{
                                        if scoreEntryVM.currentGame.game.teamAScoresArray[holeIndex+9].scoreCommitted {
                                            
                                            Text(scoreEntryVM.currentGame.game.teamAScoresArray[holeIndex+9].grossScore.formatted())
                                                .foregroundColor(.blue)
                                            
                                            if scoreEntryVM.currentGame.game.teamAScoresArray[holeIndex+9].StablefordPointsNet() != 0 {
                                                Text(scoreEntryVM.currentGame.game.teamAScoresArray[holeIndex+9].StablefordPointsNet().formatted())
                                                    .foregroundColor(burntOrange)
                                                    .font(.caption)
                                                    .offset(x: 10, y: 5)
                                            }
                                        }
                                    }
                                    
                                    ZStack{
                                        if scoreEntryVM.currentGame.game.teamBScoresArray[holeIndex+9].scoreCommitted {
                                            
                                            Text(scoreEntryVM.currentGame.game.teamBScoresArray[holeIndex+9].grossScore.formatted())
                                                .foregroundColor(.blue)
                                            
                                            if scoreEntryVM.currentGame.game.teamBScoresArray[holeIndex+9].StablefordPointsNet() != 0 {
                                                Text(scoreEntryVM.currentGame.game.teamBScoresArray[holeIndex+9].StablefordPointsNet().formatted())
                                                    .foregroundColor(burntOrange)
                                                    .font(.caption)
                                                    .offset(x: 10, y: 5)
                                            }
                                        }
                                    }
                                    
                                }
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                                .offset(x: geo.size.width * 0.026)
                            }
                        
                        case .TeamC:
                            HStack(spacing:geo.size.width * 0.048){
                                Spacer()
                                    .frame(width: geo.size.width * 0.011)
                                Group{
                                    
                                    ZStack{
                                        if scoreEntryVM.currentGame.game.teamCScoresArray[holeIndex+9].scoreCommitted {
                                            
                                            Text(scoreEntryVM.currentGame.game.teamCScoresArray[holeIndex+9].grossScore.formatted())
                                                .foregroundColor(.blue)
                                            
                                            if scoreEntryVM.currentGame.game.teamCScoresArray[holeIndex+9].StablefordPointsNet() != 0 {
                                                Text(scoreEntryVM.currentGame.game.teamCScoresArray[holeIndex+9].StablefordPointsNet().formatted())
                                                    .foregroundColor(burntOrange)
                                                    .font(.caption)
                                                    .offset(x: 10, y: 5)
                                            }
                                        }
                                    }
                                    
                                   
                                }
                                
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                                .offset(x: geo.size.width * 0.026)
                                
                            }
                            
                            
                            
                            
                        }
                        
                        //**********************************************
                        
                        
                        
                        
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
                        
                        switch currentGF.assignShotsRecd {
                            
                        case .Indiv:
                            HStack(spacing: 0){
                                Group{
                                    ForEach(scoreEntryVM.currentGame.game.SortedCompetitors(currentGF: currentGF), id: \.self){ competitor in
                                        if competitor.competitorScoresArray.TotalGrossScore_front9() != 0 {
                                            ZStack{
                                                Text(competitor.competitorScoresArray.TotalGrossScore_back9().formatted())
                                                    .foregroundColor(.blue)
                                                Text(competitor.competitorScoresArray.TotalStablefordPoints_back9().formatted())
                                                    .foregroundColor(burntOrange)
                                                    .font(.caption)
                                                    .offset(x: 15, y: 10)
                                                
                                            }
                                        }
                                    }
                                }
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                            }
                            .offset(x: geo.size.width * 0.095)
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                        case .TeamsAB:
                            EmptyView()
                        case .TeamC:
                            EmptyView()
                            
                            
                        }
                    }//back 9 HStack
               
                    
                    
                
                
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
                    switch currentGF.assignShotsRecd {
                    case .Indiv:
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
                        
                    case .TeamsAB:
                        EmptyView()
                    case .TeamC:
                        EmptyView()
                        
                    }
                }//front 9 HStack
                
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
                    switch currentGF.assignShotsRecd {
                    case .Indiv:
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
                    case .TeamsAB:
                        EmptyView()
                    case .TeamC:
                        EmptyView()
                        
                    }
                } //overall total HStack
                
                
                
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
