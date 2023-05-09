//
//  Extensions_Game.swift
//  GolfProto03
//
//  Created by Philip Nye on 14/04/2023.
//

import Foundation


extension Game {
    var sc_format: ScoreFormat {
        get{
            return ScoreFormat(rawValue: Int(self.scoreFormat)) ?? .medal
        } set {
            self.scoreFormat = Int16(newValue.rawValue)
        }
    }
}
extension Game {
    var hcap_format: HandicapFormat {
        get{
            return HandicapFormat(rawValue: Int(self.handicapFormat)) ?? .handicap
        } set {
            self.handicapFormat = Int16(newValue.rawValue)
        }
    }
}
extension Game {
    var play_format: PlayFormat {
        get{
            return PlayFormat(rawValue: Int(self.playFormat)) ?? .strokeplay
        } set {
            self.playFormat = Int16(newValue.rawValue)
        }
    }
}

extension Game {
    var game_format: GameFormatType {
        get{
            return GameFormatType(rawValue: Int(self.gameFormat)) ?? .fourBallBBMatch
        } set {
            self.gameFormat = Int16(newValue.rawValue)
        }
    }
}


extension Game {
    var game_duration: GameDuration {
        get {
            return GameDuration(rawValue: Int(self.duration)) ?? .H18
        } set {
            self.duration = Int16(newValue.rawValue)
        }
    }
}

extension Game {
    func TeeBoxesAllSame() -> Bool {
        var teeBoxes: [TeeBox] = []
        for i in 0..<self.competitorArray.count {
            teeBoxes.append(self.competitorArray[i].teeBox ?? TeeBox())
        }
        let hasAllItemsEqual = teeBoxes.dropFirst().reduce(true) { (partialResult, element) in
            return partialResult && element == teeBoxes.first
        }
        return hasAllItemsEqual
    }
}

extension Game {
    func AllScoresCommitted(holeIndex: Int) -> Bool {
        var scoresCommitted: [Bool] = []
        if self.competitorArray.first?.competitorScoresArray[holeIndex].scoreCommitted == true{
            for i in 0..<self.competitorArray.count {
                scoresCommitted.append(self.competitorArray[i].competitorScoresArray[holeIndex].scoreCommitted)
                
                //teeBoxes.append(self.competitorArray[i].teeBox ?? TeeBox())
            }
            let hasAllItemsEqual = scoresCommitted.dropFirst().reduce(true) { (partialResult, element) in
                return partialResult && element == scoresCommitted
                
                    .first
            }
            return hasAllItemsEqual
        } else {
            return false
        }
    }
}



extension Game {
    func TotalPlayingHandicapA () -> Double {
        if !self.teamShotsArray.isEmpty{
            let totalPHA = Double(self.teamShotsArray[0].playingHandicap + self.teamShotsArray[0].diffTeesXShots)
            
            return totalPHA
        } else {
            return 0.0
        }
    }
}
extension Game {
    func TotalPlayingHandicapB () -> Double {
        if !self.teamShotsArray.isEmpty{
            let totalPHB = Double(self.teamShotsArray[1].playingHandicap + self.teamShotsArray[1].diffTeesXShots)
            
            return totalPHB
        } else {
            return 0.0
        }
    }
}
extension Game {
    func TotalPlayingHandicapC () -> Double {
        if !self.teamShotsArray.isEmpty{
            let totalPHC = Double(self.teamShotsArray[2].playingHandicap + self.teamShotsArray[2].diffTeesXShots)
            
            return totalPHC
        } else {
            return 0.0
        }
    }
}

extension Game {
    func TotalShotsRecdMatchTeamA () -> Double {
        if !self.teamShotsArray.isEmpty{
            let totalSR = Double(self.teamShotsArray[0].shotsRecd + self.teamShotsArray[0].diffTeesXShots)
            
            return totalSR
        } else {
            return 0.0
        }
    }
}
extension Game {
    func TotalShotsRecdMatchTeamB () -> Double {
        if !self.teamShotsArray.isEmpty{
            let totalSR = Double(self.teamShotsArray[1].shotsRecd + self.teamShotsArray[1].diffTeesXShots)
            
            return totalSR
        } else {
            return 0.0
        }
    }
}


extension Game {
    func ShotsReceivedByTeam(holeIndex: Int, shots: Double, team: Int16) -> Int {
        
        var shots18Recd: Int = 0
        var shots36Recd: Int = 0
        var shots54Recd: Int = 0
      
        let shots18 = Int(round(shots))
        var shots36 = Int(round(shots - 18))
        if shots36 < 0 {shots36 = 0}
        var shots54 = Int(round(shots - 36))
        if shots54 < 0 {shots54 = 0}
     
        if shots18 >= self.teamScoresArray.filter({$0.team == team})[holeIndex].strokeIndex {shots18Recd = 1}
        if shots36 >= self.teamScoresArray.filter({$0.team == team})[holeIndex].strokeIndex {shots36Recd = 1}
        if shots54 >= self.teamScoresArray.filter({$0.team == team})[holeIndex].strokeIndex {shots54Recd = 1}
        
        let shotsReceived = shots18Recd + shots36Recd + shots54Recd
        return shotsReceived
    }
}

extension Game {
    func SortedCompetitorArray () -> [Competitor] {
        return self.competitorArray.sorted(by: {$0.playingHandicap < $1.playingHandicap})
    }
}

extension Game {
    func MatchResult(currentGF: CurrentGameFormat) -> [String] {
       
        var result = ["","","",""]
        var currentMatchScore: Int = 0
        var holesPlayed: Int = 0
        let holesRemaining = 18 - holesPlayed
        let holesRemainingString = "with \(holesRemaining) holes remaining"
        
        func SinglesMatchplay(){
            let teamA = self.competitorArray.filter({$0.team_String == .teamA})
            let teamB = self.competitorArray.filter({$0.team_String == .teamB})
          
            for i in 0..<18 {
                   
                   switch self.AllScoresCommitted(holeIndex: i){
                   case true:
                       holesPlayed += 1
                       
                       
                       
                       let teamANetLowScore = Int(teamA.first?.competitorScoresArray[i].NetScoreMatch() ?? 0)
                       let teamBNetLowScore = Int(teamB.first?.competitorScoresArray[i].NetScoreMatch() ?? 0)

                       
                       switch teamANetLowScore - teamBNetLowScore {
                           
                       case _ where teamANetLowScore - teamBNetLowScore < 0:
                           currentMatchScore += 1
                           
                       case _ where teamANetLowScore - teamBNetLowScore > 0:
                           currentMatchScore -= 1
                       default:
                           break
                       }
                   case false:
                       break
                   }
               
           }
            
            switch currentMatchScore {
            case 0:
                result[2] = "All square"
                result[3] = holesRemainingString
            case _ where currentMatchScore > 0:
                result[0] = "Player 1 \(currentMatchScore) UP"
                result[3] = holesRemainingString
            case _ where currentMatchScore < 0:
                result[1] = "Player 2 \(-currentMatchScore) UP"
                result[3] = holesRemainingString
            default:
                result = ["","","",""]
            }
        }
        
         func FourballBetterBall(){
             
             let teamA = self.competitorArray.filter({$0.team_String == .teamA})
             let teamB = self.competitorArray.filter({$0.team_String == .teamB})
           
             for i in 0..<18 {
                    
                    switch self.AllScoresCommitted(holeIndex: i){
                    case true:
                        holesPlayed += 1
                        
                        
                        
                        let teamANetLowScore = min(teamA[0].competitorScoresArray[i].NetScoreMatch(),teamA[1].competitorScoresArray[i].NetScoreMatch() )
                        let teamBNetLowScore = min(teamB[0].competitorScoresArray[i].NetScoreMatch(),teamB[1].competitorScoresArray[i].NetScoreMatch() )

                        
                        switch teamANetLowScore - teamBNetLowScore {
                            
                        case _ where teamANetLowScore - teamBNetLowScore < 0:
                            currentMatchScore += 1
                            
                        case _ where teamANetLowScore - teamBNetLowScore > 0:
                            currentMatchScore -= 1
                        default:
                            break
                        }
                    case false:
                        break
                    }
                
            }
             
             switch currentMatchScore {
             case 0:
                 result[2] = "All square"
                 result[3] = holesRemainingString
             case _ where currentMatchScore > 0:
                 result[0] = "team A \(currentMatchScore) UP"
                 result[3] = holesRemainingString
             case _ where currentMatchScore < 0:
                 result[1] = "team B \(-currentMatchScore) UP"
                 result[3] = holesRemainingString
             default:
                 result = ["","","",""]
             }
             
             
        }
        
        func FourballCombined(){
            
            let teamA = self.competitorArray.filter({$0.team_String == .teamA})
            let teamB = self.competitorArray.filter({$0.team_String == .teamB})
          
            for i in 0..<18 {
                   
                   switch self.AllScoresCommitted(holeIndex: i){
                   case true:
                       holesPlayed += 1
                       let teamANetLowScore = teamA[0].competitorScoresArray[i].NetScoreMatch() + teamA[1].competitorScoresArray[i].NetScoreMatch()
                       let teamBNetLowScore = teamB[0].competitorScoresArray[i].NetScoreMatch() + teamB[1].competitorScoresArray[i].NetScoreMatch()

                       
                       switch teamANetLowScore - teamBNetLowScore {
                           
                       case _ where teamANetLowScore - teamBNetLowScore < 0:
                           currentMatchScore += 1
                           
                       case _ where teamANetLowScore - teamBNetLowScore > 0:
                           currentMatchScore -= 1
                       default:
                           break
                       }
                   case false:
                       break
                   }
               
           }
            
            switch currentMatchScore {
            case 0:
                result[2] = "All square"
                result[3] = holesRemainingString
            case _ where currentMatchScore > 0:
                result[0] = "team A \(currentMatchScore) UP"
                result[3] = holesRemainingString
            case _ where currentMatchScore < 0:
                result[1] = "team B \(-currentMatchScore) UP"
                result[3] = holesRemainingString
            default:
                result = ["","","",""]
            }
            
            
       }
        
        
        switch currentGF.assignTeamGrouping {
      
            case .TeamC:
                result = ["","","",""]
            case .Indiv:
                switch currentGF.playFormat{
                            case .matchplay:
                                switch currentGF.noOfPlayersNeeded{
//                                    case 2:// singles matchplay
//                                        SinglesMatchplay()
//                                    print("singles matchplay")
                                    case 3:// 6 point game
                                        break //placeholder
                                    default:
                                    result = ["","","",""]
                                    }
                            case .strokeplay:
                    result = ["","","",""]
                        }
            case .TeamsAB:
                let teamA = self.competitorArray.filter({$0.team_String == .teamA})
                let teamB = self.competitorArray.filter({$0.team_String == .teamB})
            
            
            
                switch currentGF.assignShotsRecd {
                case .Indiv:
                    switch currentGF.playFormat{
                    case .matchplay:
                        switch currentGF.noOfPlayersNeeded{
                        case 4:
                            switch currentGF.format{
                            case .fourBallBBMatch:// 4BBB
                                FourballBetterBall()
                            case .fourBallCombinedMatch://4Bcombined
                                FourballCombined()
                            default:
                                result = ["","","",""]
                            }
                        case 2: // singles matchplay
                            SinglesMatchplay()
                        default:
                            break
                            
                        }
                    case .strokeplay:
                        result = ["","","",""]
                    }
                case .TeamsAB:
                    switch currentGF.playFormat{
                    case .matchplay://4somes, greensomes, pinehurstchapman, 2v2 texas scramble
                        break //placeholder
                    case .strokeplay:
                        result = ["","","",""]
                    }
                case .TeamC:
                    result = ["","","",""]
              
            }
        }
          
        return result
    }
}




extension Game {
    func SortedCompetitors (currentGF: CurrentGameFormat) -> [Competitor] {
       
        var sortedCompetitors: [Competitor] = []
        switch currentGF.assignTeamGrouping {
            
        case .Indiv:
            sortedCompetitors = self.competitorArray.sorted(by: {
                
                if $0.handicapIndex == $1.handicapIndex {
                    if $0.player?.firstName ?? "" == $1.player?.firstName ?? "" {
                        return $0.player?.objectID.description ?? "" < $1.player?.objectID.description ?? ""}
                    
                    return $0.player?.firstName ?? "" < $1.player?.firstName ?? "" }
                    return $0.handicapIndex < $1.handicapIndex
                
            })
       
        case .TeamsAB:
            
            sortedCompetitors = self.competitorArray.sorted(by:{
                if $0.team == $1.team {
                    if $0.handicapIndex == $1.handicapIndex {
                        if $0.player?.firstName ?? "" == $1.player?.firstName ?? "" {
                            
                            
                            return $0.player?.objectID.description ?? "" < $1.player?.objectID.description ?? ""
                            
                        }
                        return $0.player?.firstName ?? "" < $1.player?.firstName ?? ""
                    }
                    return $0.handicapIndex < $1.handicapIndex
                }
                return $0.team < $1.team
            })
            
        case .TeamC:
            sortedCompetitors = self.competitorArray.sorted(by: {
               
                if $0.handicapIndex == $1.handicapIndex {
                    if $0.player?.firstName ?? "" == $1.player?.firstName ?? "" {
                        return $0.player?.objectID.description ?? "" < $1.player?.objectID.description ?? ""}
                    
                    return $0.player?.firstName ?? "" < $1.player?.firstName ?? "" }
                    return $0.handicapIndex < $1.handicapIndex
                
            })
            
            
        }
    return sortedCompetitors
    }
}
