//
//  CompetitorScore_forArray.swift
//  GolfProto04
//
//  Created by Philip Nye on 27/04/2023.
//

import SwiftUI

struct CompetitorScore_forArray: View {
    
    var competitor: Competitor
    var holeIndex: Int
    var body: some View {
        
        
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
            }
            
       
    }
}

struct CompetitorScore_forArray_Previews: PreviewProvider {
    static var previews: some View {
        let competitor = CompetitorViewModel(competitor: Competitor(context: CoreDataManager.shared.viewContext)).competitor
        CompetitorScore_forArray(competitor: competitor, holeIndex: 0)
           
    }
}
