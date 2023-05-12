//
//  CompetitorScores_IndivTotal.swift
//  GolfProto05
//
//  Created by Philip Nye on 12/05/2023.
//

import SwiftUI

struct CompetitorScores_IndivTotal: View {
    var competitors: [Competitor] = []
   // var score = ["front", "back", "total"]
    var body: some View {
        ForEach(competitors, id: \.self){ competitor in
            
            if competitor.competitorScoresArray.TotalGrossScore() != 0 {
                
                
                
                
                
                
                ZStack{
                    Text(competitor.competitorScoresArray.TotalGrossScore().formatted())
                        .foregroundColor(.blue)
                    Text(competitor.competitorScoresArray.TotalStablefordPoints().formatted())
                        .foregroundColor(burntOrange)
                        .font(.caption)
                        .offset(x: 15, y: 10)

                }
            }
            
        }
    }
}

struct CompetitorScores_IndivTotal_Previews: PreviewProvider {
    static var previews: some View {
        CompetitorScores_IndivTotal()
    }
}
