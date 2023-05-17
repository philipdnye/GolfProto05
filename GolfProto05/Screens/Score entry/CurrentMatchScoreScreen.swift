//
//  CurrentMatchScoreScreen.swift
//  GolfProto05
//
//  Created by Philip Nye on 16/05/2023.
//

import SwiftUI

struct CurrentMatchScoreScreen: View {
    @EnvironmentObject var currentGF: CurrentGameFormat
    @Binding var neeedsRefresh: Bool
    var game: GameViewModel
    var body: some View {
        let currentMatchScore = game.game.CalcCurrentMatchScore(currentGF: currentGF, byHole: false, holeIndex: nil).0
        let holesPlayed = game.game.CalcCurrentMatchScore(currentGF: currentGF, byHole: false, holeIndex: nil).1
        HStack{
            Text(game.game.CurrentMatchScoreString(currentMatchScore: currentMatchScore, holesPlayed: holesPlayed, currentGF: currentGF).0)
            Text(game.game.CurrentMatchScoreString(currentMatchScore: currentMatchScore, holesPlayed: holesPlayed, currentGF: currentGF).1)

            Text(neeedsRefresh.description)
                .frame(width: 0, height: 0)
                .opacity(0)
        }
    }
}

struct CurrentMatchScoreScreen_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        CurrentMatchScoreScreen(neeedsRefresh: .constant(false),game: game)
            .environmentObject(CurrentGameFormat())
    }
}
