//
//  TeamScores.swift
//  GolfProto05
//
//  Created by Philip Nye on 12/05/2023.
//

import SwiftUI

struct TeamScores: View {
    
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

struct TeamScores_Previews: PreviewProvider {
    static var previews: some View {
        TeamScores(grossTotal: 0, pointsTotal: 0)
    }
}
