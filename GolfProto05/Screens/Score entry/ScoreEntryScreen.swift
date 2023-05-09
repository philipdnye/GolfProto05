//
//  ScoreEntryScreen.swift
//  GolfProto04
//
//  Created by Philip Nye on 25/04/2023.
//

import SwiftUI

struct ScoreEntryScreen: View {
    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    @EnvironmentObject var currentGF: CurrentGameFormat
    @Environment(\.dismiss) private var dismiss
    @State private var showHoleNavigator: Bool = false
    @State private var isShowingDialogueCommitScores: Bool = false
    @State private var isPresentedSheetScoreCard: Bool = false
   
    var game: GameViewModel
    
    private var scoreCardButton: some View {
        AnyView(Button(action: showScorecard){Image(systemName: "list.number")})
    }
    private func showScorecard () {
        isPresentedSheetScoreCard.toggle()
    }
    
    var body: some View {
        ZStack{
            GeometryReader { geo in
                HoleNavigatorPopUp(scoreEntryVM: scoreEntryVM,showHoleNavigator: $showHoleNavigator)
                    .zIndex(1)
                    .offset(x:geo.size.width * 0.1, y: geo.size.height * 0.195)
                
                
                HStack(spacing: 0){
                    
                    Text(game.name)
                        .frame(width: geo.size.width * 0.48, alignment: .leading)
                        .offset(x:geo.size.width * 0.02, y: geo.size.height * 0.02)
                    Text(game.game.scoreEntryTeeBox?.course?.club?.wrappedName ?? "")
                        .frame(width: geo.size.width * 0.48, alignment: .trailing)
                        .offset(x:geo.size.width * 0.02, y: geo.size.height * 0.02)
                }
                .font(.title2)
                .foregroundColor(darkTeal)
                .zIndex(0)
                
                HStack(spacing: 0){
                    Text("\(game.game.scoreEntryTeeBox?.wrappedColour.capitalizingFirstLetter() ?? "no teebox found") tees") //teeBox for game
                        .frame(width:geo.size.width * 0.26, alignment: .leading)
                    
                    Text(String(game.game.scoreEntryTeeBox?.TotalDistance() ?? 0) + (game.game.scoreEntryTeeBox?.course?.club?.dist_metric.stringValueInitial() ?? ""))
                        .frame(width:geo.size.width * 0.18, alignment: .leading)
                    
                    Text("Par: \(game.game.scoreEntryTeeBox?.TotalPar() ?? 0)")
                        .frame(width:geo.size.width * 0.2, alignment: .leading)
                    
                    
                    
//                    Text(game.game.scoreEntryTeeBox?.course?.name ?? "")
//                        .frame(width:geo.size.width * 0.32, alignment: .trailing)
                    
                }
                .zIndex(0)
                .offset(x:geo.size.width * 0.02, y: geo.size.height * 0.058)
                .foregroundColor(darkTeal)
                HStack(spacing:0){
                    Text(game.game.game_format.stringValue())
                        .frame(width: geo.size.width * 0.37, alignment: .leading)
                        .offset(x:geo.size.width * 0.02, y: geo.size.height * 0.088)
                    Text(currentGF.playFormat.stringValue())
                        .frame(width: geo.size.width * 0.21, alignment: .center)
                        .offset(x:geo.size.width * 0.00, y: geo.size.height * 0.088)
                    Text(game.game.sc_format.stringValue())
                        .frame(width: geo.size.width * 0.21, alignment: .center)
                        .offset(x:geo.size.width * 0.00, y: geo.size.height * 0.088)
                    Text(game.game.hcap_format.stringValue())
                        .frame(width: geo.size.width * 0.21, alignment: .center)
                    
                    
                        .offset(x:geo.size.width * 0.00, y: geo.size.height * 0.088)
                }
                .font(.subheadline)
                .foregroundColor(darkTeal)
                .zIndex(0)
                HStack(spacing: 0){
                    Text("Hole ")
                    Text(String(scoreEntryVM.holeIndex + 1))
                    Spacer()
                        .frame(width:3)
                    Button {
                        showHoleNavigator.toggle()
                    } label: {
                        
                        
                        
                        Label("", systemImage: "arrowtriangle.down.fill")
                            .font(.system(size: 20))
                        
                    }
                    
                    
                    
                    .background(burntOrange)
                    
                    
                    .foregroundColor(.white)
                    
                     
                    
                }
                .frame(width: geo.size.width * 1, height: 50)
                .font(.title)
                .background(burntOrange)
                .foregroundColor(.white)
                .offset(x:0, y: geo.size.height * 0.15)
                .zIndex(0)
                
                
                
                
                
                HStack{
                    Text(String(game.game.scoreEntryTeeBox?.holesArray[scoreEntryVM.holeIndex].distance ?? 0))
                    Text("Par \(game.game.scoreEntryTeeBox?.holesArray[scoreEntryVM.holeIndex].par ?? 0)")
                    Text("S.I. \(game.game.scoreEntryTeeBox?.holesArray[scoreEntryVM.holeIndex].strokeIndex ?? 0)")
                }
                .frame(width: geo.size.width * 1, height: 50)
                .font(.title2)
                .background(gold)
                .foregroundColor(darkTeal)
                .offset(x:0, y: geo.size.height * 0.23)
                .zIndex(0)
                
                
                
                if scoreEntryVM.holeIndex != 0 {
                    
                    Button("< Hole \(scoreEntryVM.holeIndex)"){
                        
                        scoreEntryVM.holeIndex -= 1
                        //games.allGames[scoreEntryVar.CGI].lastHoleIndex = scoreEntryVar.holeIndex
                        
                    }
                    .buttonStyle(HoleButton())
                    
                    .frame(width: geo.size.width * 0.27, height: 50)
                    .offset(x:geo.size.width * 0.05, y: geo.size.height * 0.15)
                    //.padding([.leading], 25)
                    .disabled(scoreEntryVM.holeIndex == 0)
                    .zIndex(0)
                }
                
                if scoreEntryVM.holeIndex != 17 {
                    
                    Button("Hole \(scoreEntryVM.holeIndex + 2) >"){
                        
                        //code here to check to see if any of score have been changed -> dialouge box
                        if scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex].allSatisfy({$0 == false}){
                            isShowingDialogueCommitScores.toggle()
                            
                        } else {
                            // if they aren't all false it suggests that user has chnaged the ones they need to so move forward and commit all scores
                            
                            for i in 0..<game.game.competitorArray.count {
                                scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][i] = true
                            }
                            
                            
                            scoreEntryVM.saveCompetitorsScore(currentGF: currentGF)
                            scoreEntryVM.holeIndex += 1
                        }
                        
                        
                        
                        //games.allGames[scoreEntryVar.CGI].lastHoleIndex = scoreEntryVar.holeIndex
                        
                    }
                    .buttonStyle(HoleButton())
                    
                    .frame(width: geo.size.width * 0.27, height: 50)
                    .offset(x:geo.size.width * 0.68, y: geo.size.height * 0.15)
                    //.padding([.leading], 25)
                    .disabled(scoreEntryVM.holeIndex == 17)
                    .zIndex(0)
                    .confirmationDialog("Confirm scores", isPresented: $isShowingDialogueCommitScores, actions: {
                        Button("Commit scores", role: .destructive){
                            for i in 0..<game.game.competitorArray.count {
                                scoreEntryVM.scoresCommitted[scoreEntryVM.holeIndex][i] = true
                            }
                            scoreEntryVM.saveCompetitorsScore(currentGF: currentGF)
                            scoreEntryVM.holeIndex += 1
                        }
                        
                    }, message: {Text("You haven't amended any scores on this hole. Commit these scores and continue to the next hole?")})
                    
                }
               
                ForEach(Array(game.game.SortedCompetitors(currentGF: currentGF).enumerated()), id: \.element){index, item in
                    ScoreEntryCompetitorRow(competitorIndex: index)
                        .frame(width: geo.size.width * 0.95, height: 75)
                        .offset(x: 0, y: geo.size.height * CGFloat(((Double(index)+1)*0.15)+0.2))
                   // print("index \(index)")
                    
                }
                
                
                
                
//                ForEach(0..<game.game.competitorArray.count, id: \.self){ i in
//                    let yOffset: CGFloat = geo.size.height * CGFloat(((Double(i)+1)*0.15)+0.2)
//                    ScoreEntryCompetitorRow(competitorIndex:  i)
//                        .frame(width: geo.size.width * 0.95, height: 75)
//                        .offset(x: 0, y: yOffset)
//                }
               
//                game.game.SortedCompetitors(currentGF: currentGF).enumerated().forEach({index,item in
//                    var i = index
//                    let yOffset: CGFloat = geo.size.height * CGFloat(((Double(i)+1)*0.15)+0.2)
//                    ScoreEntryCompetitorRow(competitorIndex:  i)
//                        .frame(width: geo.size.width * 0.95, height: 75)
//                        .offset(x: 0, y: yOffset)})
//
//                }
                
                
                
                
                
                HStack{
                    Text(game.game.MatchResult(currentGF: currentGF)[0])
                    Text(game.game.MatchResult(currentGF: currentGF)[1])
                    Text(game.game.MatchResult(currentGF: currentGF)[2])
                    Text(game.game.MatchResult(currentGF: currentGF)[3])
                    
                }
                .frame(width: geo.size.width * 0.95, height: 35)
                .offset(x: 0, y: geo.size.height * 0.93)
                .foregroundColor(darkTeal)
                
                
                
                //for testing purposes
//                HStack{
//                    ForEach(0..<game.game.competitorArray.count, id: \.self) {i in
//                        Text(game.game.competitorArray[i].competitorScoresArray.count.formatted())
//                    }
//                    Button("Save scores"){
//                        scoreEntryVM.saveCompetitorsScore()
//                    }
//                }
                
//                .confirmationDialog(isPresented: $isShowingDialogueCommitScores){
//                    //code in here
//
//                } message: {
//
//                    Text("You haven't amended any scores on this hole? Do you want to commit these scores to the game and continue to the next hole")
//                }
                
                
            }//geo
            
        }
       
//        NavigationLink("Press Me", destination: Text("Detail").navigationTitle("Detail View"))
//                    .navigationBarTitleDisplayMode(.inline)
//                    // this sets the Back button text when a new screen is pushed
//                    .navigationTitle("Back to Primary View")
//                    .toolbar {
//                        ToolbarItem(placement: .principal) {
//                            // this sets the screen title in the navigation bar, when the screen is visible
//                            Text("Primary View")
//                        }
//                    }
        //.navigationTitle("Nav title")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button {
                    //code here to save competitorscores
                    scoreEntryVM.saveCompetitorsScore(currentGF: currentGF)
                    dismiss()
                } label: {
                    
                    Text("Pause game")
                                            
                }
                
                }
            
            
            ToolbarItem(placement: .navigationBarLeading){
                scoreCardButton
            }
            }
        
        
        .sheet(isPresented: $isPresentedSheetScoreCard, onDismiss: {
            
           
        }, content: {
           ScorecardScreen()
        })
        
        
    }
}

struct ScoreEntryScreen_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        ScoreEntryScreen(game: game)
            .environmentObject(ScoreEntryViewModel())
            .environmentObject(CurrentGameFormat())
            
    }
}
