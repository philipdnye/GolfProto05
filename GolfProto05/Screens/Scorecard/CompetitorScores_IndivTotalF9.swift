//
//  CompetitorScores_IndivTotalF9.swift
//  GolfProto05
//
//  Created by Philip Nye on 12/05/2023.
//

import SwiftUI

struct CompetitorScores_IndivTotalF9: View {
    
    var competitors: [Competitor] = []
   
    
    var body: some View {
        
        ForEach(competitors, id: \.self){ competitor in
            
            if competitor.competitorScoresArray.TotalGrossScore_front9() != 0 {
                ZStack{
                    Text(competitor.competitorScoresArray.TotalGrossScore_front9().formatted())
                        .foregroundColor(.blue)
                    Text(competitor.competitorScoresArray.TotalStablefordPoints_front9().formatted())
                        .foregroundColor(burntOrange)
                        .font(.caption)
                        .offset(x: 15, y: 10)

                }
            }
            
        }
    }
}

struct CompetitorScores_IndivTotalF9_Previews: PreviewProvider {
    static var previews: some View {
        CompetitorScores_IndivTotalF9()
            
    }
}
