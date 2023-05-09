//
//  CompetitorScores.swift
//  GolfProto04
//
//  Created by Philip Nye on 08/05/2023.
//

import SwiftUI

struct CompetitorScores: View {
    var competitor: Competitor
    var grossTotal: Int16
    var pointsTotal: Int16
    var body: some View {
        
        ZStack{
            Text(grossTotal.formatted())
                .foregroundColor(.blue)
            Text(pointsTotal.formatted())
                .foregroundColor(burntOrange)
                .font(.caption)
                .offset(x: 15, y: 10)
        }
    }
}

struct CompetitorScores_Previews: PreviewProvider {
    static var previews: some View {
        let competitor = CompetitorViewModel(competitor: Competitor(context: CoreDataManager.shared.viewContext)).competitor
        CompetitorScores(competitor: competitor, grossTotal: 0, pointsTotal: 0)
    }
}
