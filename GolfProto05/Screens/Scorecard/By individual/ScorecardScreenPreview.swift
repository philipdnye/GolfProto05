//
//  ScorecardScreen.swift
//  GolfProto04
//
//  Created by Philip Nye on 27/04/2023.
//

import SwiftUI

struct ScorecardScreenPreview: View {
    @EnvironmentObject var scoreEntryVM: ScoreEntryViewModel
    var body: some View {
       
       
        let initials = ["PN", "JD", "PS", "TB"]
        let scores = [5,7,13,6]
        //let points = [3,0,1,2]
        let totalscores = [44,34,36,51]
        let finalScores = [88,104,78,91]
        GeometryReader{geo in
            
            
            List{
                HStack(spacing: 0){
                    Group{
                        ForEach(initials, id: \.self){initials in
                            Text(initials)
                        }
                    }
                    .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                }
                .offset(x: geo.size.width * 0.3)
                .foregroundColor(darkTeal)
                
                
                ForEach(0..<9){i in
                    HStack(spacing:0){
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].number.formatted() ?? "")
                        Text((i+1).formatted())
                            .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].distance.formatted() ?? "")
                        Text("377")
                            .frame(width: geo.size.width * 0.1, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].par.formatted() ?? "")
                        Text("5")
                            .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].strokeIndex.formatted() ?? "")
                        Text("15")
                            .frame(width: geo.size.width * 0.075, height: geo.size.height * 0.03)
                            .foregroundColor(burntOrange)
                        
                     //   ****ADD POINTS HERE**********
                        
                        
                        
                        
                        HStack(spacing:0){
                            Group{
                                ForEach(scores, id:\.self){score in
                                    Text(score.formatted())
                                }
                            }
                            .foregroundColor(.blue)
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                            .offset(x: geo.size.width * 0.026)
                        }
                    }
                }
               
                
                
                HStack(spacing:0){
                    //hole summary front 9
                    HStack(spacing:0){
                        Text ("3456")
                            .frame(width:geo.size.width * 0.15)
                        Text("36")
                            .frame(width:geo.size.width * 0.065)
                    }
                    .foregroundColor(darkTeal)
                    .fontWeight(.semibold)
                    
                    
                    
                    
                    // players front 9 totals
                    HStack(spacing: 0){
                        Group{
                            ForEach(totalscores, id:\.self){score in
                                Text(score.formatted())
                                    .foregroundColor(.blue)
                                    .fontWeight(.semibold)
                            }
                        }
                        .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                    }
                    .offset(x: geo.size.width * 0.085)
                    
                    
                }
                
                
                
                ForEach(9..<18){i in
                    HStack(spacing:0){
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].number.formatted() ?? "")
                        Text((i+1).formatted())
                            .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].distance.formatted() ?? "")
                        Text("377")
                            .frame(width: geo.size.width * 0.1, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].par.formatted() ?? "")
                        Text("5")
                            .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.03)
                            .foregroundColor(darkTeal)
                        //Text(scoreEntryVM.currentGame.game.scoreEntryTeeBox?.holesArray[i].strokeIndex.formatted() ?? "")
                        Text("15")
                            .frame(width: geo.size.width * 0.075, height: geo.size.height * 0.03)
                            .foregroundColor(burntOrange)
                        
                        HStack(spacing:0){
                            Group{
                                ForEach(scores, id:\.self){score in
                                    Text(score.formatted())
                                }
                            }
                            .foregroundColor(.blue)
                            .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                            .offset(x: geo.size.width * 0.026)
                        }
                        
                        
                        
                        
                        
                        
                    }
                }
                
                // players back 9 totals
                HStack(spacing:0){
                    //hole summary front 9
                    HStack(spacing:0){
                        Text ("3456")
                            .frame(width:geo.size.width * 0.15)
                        Text("36")
                            .frame(width:geo.size.width * 0.065)
                    }
                    .foregroundColor(darkTeal)
                    .fontWeight(.semibold)
                    
                    
                    
                    
                    // players front 9 totals
                    HStack(spacing: 0){
                        Group{
                            ForEach(totalscores, id:\.self){score in
                                Text(score.formatted())
                            }
                        }
                        .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                    }
                    .offset(x: geo.size.width * 0.085)
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                    
                }
                
                // players front 9 totals
                HStack(spacing:0){
                    //hole summary front 9
                    HStack(spacing:0){
                        Text ("3456")
                            .frame(width:geo.size.width * 0.15)
                        Text("36")
                            .frame(width:geo.size.width * 0.065)
                    }
                    .foregroundColor(darkTeal)
                    .fontWeight(.semibold)
                    
                    
                    
                    
                    // players front 9 totals
                    HStack(spacing: 0){
                        Group{
                            ForEach(totalscores, id:\.self){score in
                                Text(score.formatted())
                            }
                        }
                        .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                    }
                    .offset(x: geo.size.width * 0.085)
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                    
                }
                
                // players  totals
                HStack(spacing:0){
                    //hole summary front 9
                    HStack(spacing:0){
                        Text ("6573")
                            .frame(width:geo.size.width * 0.15)
                        Text("72")
                            .frame(width:geo.size.width * 0.065)
                    }
                    .foregroundColor(darkTeal)
                    .fontWeight(.semibold)
                    
                    
                    
                    
                    // players front 9 totals
                    HStack(spacing: 0){
                        Group{
                            ForEach(finalScores, id:\.self){score in
                                Text(score.formatted())
                            }
                        }
                        .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                    }
                    .offset(x: geo.size.width * 0.085)
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                    
                }
                
                
                
                HStack(spacing: 0){
                    Group{
                        ForEach(initials, id: \.self){initials in
                            Text(initials)
                        }
                           
                    }
                    .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.03)
                }
                .offset(x: geo.size.width * 0.3)
                .foregroundColor(darkTeal)
                
            }
            
            
        }
    }
}

struct ScorecardScreenPreview_Previews: PreviewProvider {
    static var previews: some View {
        
        ScorecardScreenPreview()
            .environmentObject(ScoreEntryViewModel())
    }
}
