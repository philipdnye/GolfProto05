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
    func AllScoresCommittedTeamAB(holeIndex: Int) -> Bool {
        var scoresCommitted: [Bool] = []
        if self.teamAScoresArray[holeIndex].scoreCommitted == true {
       
            scoresCommitted.append(self.teamAScoresArray[holeIndex].scoreCommitted)
            scoresCommitted.append(self.teamBScoresArray[holeIndex].scoreCommitted)
           
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
     
        if shots18 >= self.teamScoresArray.filter({$0.team == team})[holeIndex].strokeIndex {shots18Recd = 1}//is the problem that the index doesnt work on filtered list???/
        if shots36 >= self.teamScoresArray.filter({$0.team == team})[holeIndex].strokeIndex {shots36Recd = 1}
        if shots54 >= self.teamScoresArray.filter({$0.team == team})[holeIndex].strokeIndex {shots54Recd = 1}
        
        let shotsReceived = shots18Recd + shots36Recd + shots54Recd
        return shotsReceived
    }
}

extension Game {
    func ShotsReceivedByTeamPerHole(strokeIndex: Int, shots: Double) -> Int {
        var shots18Recd: Int = 0
        var shots36Recd: Int = 0
        var shots54Recd: Int = 0

        let shots18 = Int(round(shots))
        var shots36 = Int(round(shots - 18))
        if shots36 < 0 {shots36 = 0}
        var shots54 = Int(round(shots - 36))
        if shots54 < 0 {shots54 = 0}
        
        if shots18 >= strokeIndex {shots18Recd = 1}
        if shots36 >= strokeIndex {shots36Recd = 1}
        if shots54 >= strokeIndex {shots54Recd = 1}

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

extension Game {
    func MatchResultHole(currentGF: CurrentGameFormat, holeIndex: Int) -> [String] {
        var result = ["","",""]
        var currentMatchScore: Int = 0
        var holesPlayed: Int = 0
        
        func Foursomes(){
            let teamAScores = self.teamScoresArray.filter({$0.team == 0}).sorted(by: {$0.hole < $1.hole})
            let teamBScores = self.teamScoresArray.filter({$0.team == 1}).sorted(by: {$0.hole < $1.hole})
            
            for i in 0..<holeIndex+1 {
                   
                   switch self.AllScoresCommittedTeamAB(holeIndex: i){
                   case true:
                       holesPlayed += 1
                  
                       let teamANetLowScore = teamAScores[i].NetScoreMatch()
                       let teamBNetLowScore = teamBScores[i].NetScoreMatch()
                     
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
            let holesRemaining = 18 - holesPlayed
            let holesRemainingString = "with \(holesRemaining) holes remaining"
            
            // results when game still in play ie not at dormie or won/lost
            if currentMatchScore >= 0 && currentMatchScore < holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) < holesRemaining {
                
                
                switch currentMatchScore {
                case 0:
                    result[0] = " - "
                    result[1] = "A/S"
                    result[2] = " - "
                    //result[3] = holesRemainingString
                case _ where currentMatchScore > 0:
                    result[0] = "\(currentMatchScore) UP"
                    //result[3] = holesRemainingString
                case _ where currentMatchScore < 0:
                    result[2] = "\(-currentMatchScore) UP"
                    result[0] = "    "
                    //result[3] = holesRemainingString
                default:
                    result = ["","",""]
                }
                
            }
            // results when game at dormie
            if currentMatchScore >= 0 && currentMatchScore == holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) == holesRemaining {
                switch currentMatchScore {
                case 0:
                    result[2] = "Match halved"
                  //  result[3] = ""
                case _ where currentMatchScore > 0:
                    result[0] = "Team A DORMIE \(currentMatchScore) UP"
                   // result[3] = ""
                case _ where currentMatchScore < 0:
                    result[1] = "Team B  DORMIE \(-currentMatchScore) UP"
                    //result[3] = ""
                default:
                    result = ["","",""]
                    
                }
            }
            //results when game won or lost
            if currentMatchScore >= 0 && currentMatchScore > holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) > holesRemaining {
                switch currentMatchScore {
                case _ where currentMatchScore > 0:
                    if holesRemaining != 0 {
                        result[0] = "Team A WON \(currentMatchScore) & \(holesRemaining)"
                      //  result[3] = ""
                    } else {
                        result[0] = "Team A WON \(currentMatchScore) UP"
                       // result[3] = ""
                    }
                case _ where currentMatchScore < 0:
                    if holesRemaining != 0 {
                        result[1] = "Team B WON \(-currentMatchScore) & \(holesRemaining)"
                        //result[3] = ""
                    } else {
                        result[0] = "Team B WON \(-currentMatchScore) UP"
                       // result[3] = ""
                    }
                default:
                    result = ["","",""]
                    
                }
            }
        }
        Foursomes()
        return result
    }
   
}

extension Game {
    func MatchResultHole1(currentGF: CurrentGameFormat, holeIndex: Int) -> (String, String, String, String) {
        var result = ["","",""]
        var currentMatchScore: Int = 0
        var holesPlayed: Int = 0
        var result0 = ""
        var result1 = ""
        var result2 = ""
        var result3 = ""
        func Foursomes(){
            let teamAScores = self.teamScoresArray.filter({$0.team == 0}).sorted(by: {$0.hole < $1.hole})
            let teamBScores = self.teamScoresArray.filter({$0.team == 1}).sorted(by: {$0.hole < $1.hole})
            
            for i in 0..<holeIndex+1 {
                   
                   switch self.AllScoresCommittedTeamAB(holeIndex: i){
                   case true:
                       holesPlayed += 1
                  
                       let teamANetLowScore = teamAScores[i].NetScoreMatch()
                       let teamBNetLowScore = teamBScores[i].NetScoreMatch()
                     
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
            let holesRemaining = 18 - holesPlayed
            let holesRemainingString = "with \(holesRemaining) holes remaining"
            
            // results when game still in play ie not at dormie or won/lost
            if currentMatchScore >= 0 && currentMatchScore < holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) < holesRemaining {
                
                
                switch currentMatchScore {
                case 0:
                     result0 = " - "
                     result1 = "A/S"
                     result2 = " - "
                     result3 = "green"
                    //result[3] = holesRemainingString
                case _ where currentMatchScore > 0:
                   // result[0] = "\(currentMatchScore) UP"
                    result0 = "\(currentMatchScore) UP"
                    result1 = ""
                    result2 = ""
                    result3 = "red"
                    
                    
                    //result[3] = holesRemainingString
                case _ where currentMatchScore < 0:
                    result2 = "\(-currentMatchScore) UP"
                    result0 = ""
                    result1 = ""
                    result3 = "blue"
                    //result[3] = holesRemainingString
                default:
                    result0 = ""
                    result1 = ""
                    result2 = ""
                    result3 = "green"
                }
                
            }
            // results when game at dormie
            if currentMatchScore >= 0 && currentMatchScore == holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) == holesRemaining {
                switch currentMatchScore {
                case 0:
                    result[2] = "Match halved"
                  //  result[3] = ""
                case _ where currentMatchScore > 0:
                    result[0] = "Team A DORMIE \(currentMatchScore) UP"
                   // result[3] = ""
                case _ where currentMatchScore < 0:
                    result[1] = "Team B  DORMIE \(-currentMatchScore) UP"
                    //result[3] = ""
                default:
                    result = ["","",""]
                    
                }
            }
            //results when game won or lost
            if currentMatchScore >= 0 && currentMatchScore > holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) > holesRemaining {
                switch currentMatchScore {
                case _ where currentMatchScore > 0:
                    if holesRemaining != 0 {
                        result[0] = "Team A WON \(currentMatchScore) & \(holesRemaining)"
                      //  result[3] = ""
                    } else {
                        result[0] = "Team A WON \(currentMatchScore) UP"
                       // result[3] = ""
                    }
                case _ where currentMatchScore < 0:
                    if holesRemaining != 0 {
                        result[1] = "Team B WON \(-currentMatchScore) & \(holesRemaining)"
                        //result[3] = ""
                    } else {
                        result[0] = "Team B WON \(-currentMatchScore) UP"
                       // result[3] = ""
                    }
                default:
                    result = ["","",""]
                    
                }
            }
        }
        Foursomes()
        return (result0, result1, result2, result3)
    }
   
}


extension Game {
    func MatchResult(currentGF: CurrentGameFormat) -> [String] {
       
        var result = ["","","",""]// Output a 4 field string array
        //0 - Indiv or Team A
        //1 - Team B
        //2 - Team C
        //3 - Holes remaining
        var currentMatchScore: Int = 0
        var holesPlayed: Int = 0
        
        
        
        func SixPoint() {
            
            let sixPointNetScores_CompetitorA = self.SortedCompetitors(currentGF: currentGF)[0].competitorScoresArray
            let sixPointNetScores_CompetitorB = self.SortedCompetitors(currentGF: currentGF)[1].competitorScoresArray
            let sixPointNetScores_CompetitorC = self.SortedCompetitors(currentGF: currentGF)[2].competitorScoresArray
            
            var array = [0,0,0]
            var holeResult: Int = 0
            var points = [0,0,0]
            
            for i in 0..<18 {
                
                switch self.AllScoresCommitted(holeIndex: i){
                case true:
                    holesPlayed += 1
                    array[0] = Int(sixPointNetScores_CompetitorA[i].NetScoreMatch())
                    array[1] = Int(sixPointNetScores_CompetitorB[i].NetScoreMatch())
                    array[2] = Int(sixPointNetScores_CompetitorC[i].NetScoreMatch())
                    
                    
                    
                    switch array {
                    case _ where array[0] == array[1] && array[1] == array[2]:
                        holeResult = 1
                        
                    case _ where array[0] < array[1] && array[1] == array[2]:
                        holeResult = 2
                        
                    case _ where array[0] < array[1] && array[1] < array[2]:
                        holeResult = 3
                        
                    case _ where array[0] < array[1] && array[1] > array[2] && array[0] < array[2]:
                        holeResult = 4
                        
                    case _ where array[0] > array[1] && array[0] == array[2]:
                        holeResult = 5
                        
                    case _ where array[0] > array[1] && array[2] > array[1] && array[0] < array[2]:
                        holeResult = 6
                        
                    case _ where array[0] > array[1] && array[2] > array[1] && array[0] > array[2]:
                        holeResult = 7
                        
                    case _ where array[2] < array[1] && array[1] == array[0]:
                        holeResult = 8
                        
                    case _ where array[2] < array[0] && array[2] < array[1] && array[0] < array[1]:
                        holeResult = 9
                        
                    case _ where array[2] < array[0] && array[2] < array[1] && array[1] < array[0]:
                        holeResult = 10
                        
                    case _ where array[0] == array[1] && array[1] < array[2]:
                        holeResult = 11
                        
                    case _ where array[0] == array[2] && array[0] < array[1]:
                        holeResult = 12
                        
                    case _ where array[1] == array[2] && array[0] > array[1]:
                        holeResult = 13
                        
                    default:
                        holeResult = 0
                        
                    }
                    switch holeResult {
                    case 1:
                        points[0] += 2
                        points[1] += 2
                        points[2] += 2
                        
                    case 2:
                        points[0] += 4
                        points[1] += 1
                        points[2] += 1
                        
                    case 3:
                        points[0] += 4
                        points[1] += 2
                        points[2] += 0
                        
                    case 4:
                        points[0] += 4
                        points[1] += 0
                        points[2] += 2
                        
                    case 5:
                        points[0] += 1
                        points[1] += 4
                        points[2] += 1
                        
                    case 6:
                        points[0] += 2
                        points[1] += 4
                        points[2] += 0
                        
                    case 7:
                        points[0] += 0
                        points[1] += 4
                        points[2] += 2
                        
                    case 8:
                        points[0] += 1
                        points[1] += 1
                        points[2] += 4
                        
                    case 9:
                        points[0] += 2
                        points[1] += 0
                        points[2] += 4
                        
                    case 10:
                        points[0] += 0
                        points[1] += 2
                        points[2] += 4
                        
                    case 11:
                        points[0] += 3
                        points[1] += 3
                        points[2] += 0
                        
                    case 12:
                        points[0] += 3
                        points[1] += 0
                        points[2] += 3
                        
                    case 13:
                        points[0] += 0
                        points[1] += 3
                        points[2] += 3
                        
                    default:
                        points[0] += 0
                        points[1] += 0
                        points[2] += 0
                        
                    }
                case false:
                    break
                }
            } //for each loop
            
            let holesRemaining = 18 - holesPlayed
            let holesRemainingString = "with \(holesRemaining) holes remaining"
            
            result[0] =  "\(self.SortedCompetitors(currentGF: currentGF)[0].player?.firstName ?? "") \(points[0]) pts"
            result[1] =  "\(self.SortedCompetitors(currentGF: currentGF)[1].player?.firstName ?? "") \(points[1]) pts"
            result[2] =  "\(self.SortedCompetitors(currentGF: currentGF)[2].player?.firstName ?? "") \(points[2]) pts"
            result[3] = holesRemainingString
        }// sixpoint func
        
        func SinglesMatchplay(){
            let teamA = self.competitorArray.filter({$0.team_String == .teamA})
            let teamB = self.competitorArray.filter({$0.team_String == .teamB})
          //boiler plate - just need variables for teamANetLowScore, teamBNetLowScore, and whether individuals or a team
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
            let holesRemaining = 18 - holesPlayed
            let holesRemainingString = "with \(holesRemaining) holes remaining"
            
            
            
            // results when game still in play ie not at dormie or won/lost
            if currentMatchScore >= 0 && currentMatchScore < holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) < holesRemaining {
                
                
                switch currentMatchScore {
                case 0:
                    result[2] = "All square"
                    result[3] = holesRemainingString
                case _ where currentMatchScore > 0:
                    result[0] = "\(teamA.first?.player?.firstName ?? "") \(currentMatchScore) UP"
                    result[3] = holesRemainingString
                case _ where currentMatchScore < 0:
                    result[1] = "\(teamB.first?.player?.firstName ?? "") \(-currentMatchScore) UP"
                    result[3] = holesRemainingString
                default:
                    result = ["","","",""]
                }
                
            }
            
            // results when game at dormie
            if currentMatchScore >= 0 && currentMatchScore == holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) == holesRemaining {
                switch currentMatchScore {
                case 0:
                    result[2] = "Match halved"
                    result[3] = ""
                case _ where currentMatchScore > 0:
                    result[0] = "\(teamA.first?.player?.firstName ?? "") DORMIE \(currentMatchScore) UP"
                    result[3] = ""
                case _ where currentMatchScore < 0:
                    result[1] = "\(teamB.first?.player?.firstName ?? "") DORMIE \(-currentMatchScore) UP"
                    result[3] = ""
                default:
                    result = ["","","",""]
                }
                
                
            }
            //results when game won or lost
            if currentMatchScore >= 0 && currentMatchScore > holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) > holesRemaining {
                switch currentMatchScore {
                case _ where currentMatchScore > 0:
                    if holesRemaining != 0 {
                        result[0] = "\(teamA.first?.player?.firstName ?? "") WON \(currentMatchScore) & \(holesRemaining)"
                        result[3] = ""
                    } else {
                        result[0] = "\(teamA.first?.player?.firstName ?? "") WON \(currentMatchScore) UP"
                        result[3] = ""
                    }
                case _ where currentMatchScore < 0:
                    if holesRemaining != 0 {
                        result[1] = "\(teamB.first?.player?.firstName ?? "") WON \(-currentMatchScore) & \(holesRemaining)"
                        result[3] = ""
                    } else {
                        result[0] = "\(teamB.first?.player?.firstName ?? "") WON \(-currentMatchScore) UP"
                        result[3] = ""
                    }
                default:
                    result = ["","","",""]
                    
                }
                
                
                
                
                
            }
        } //singles matchplay func
        
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
            
            
            let holesRemaining = 18 - holesPlayed
            let holesRemainingString = "with \(holesRemaining) holes remaining"
        
            
            // results when game still in play ie not at dormie or won/lost
            if currentMatchScore >= 0 && currentMatchScore < holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) < holesRemaining {
                
                
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
            // results when game at dormie
            if currentMatchScore >= 0 && currentMatchScore == holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) == holesRemaining {
                switch currentMatchScore {
                case 0:
                    result[2] = "Match halved"
                    result[3] = ""
                case _ where currentMatchScore > 0:
                    result[0] = "Team A DORMIE \(currentMatchScore) UP"
                    result[3] = ""
                case _ where currentMatchScore < 0:
                    result[1] = "Team B  DORMIE \(-currentMatchScore) UP"
                    result[3] = ""
                default:
                    result = ["","","",""]
                    
                }
            }
            //results when game won or lost
            if currentMatchScore >= 0 && currentMatchScore > holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) > holesRemaining {
                switch currentMatchScore {
                case _ where currentMatchScore > 0:
                    if holesRemaining != 0 {
                        result[0] = "Team A WON \(currentMatchScore) & \(holesRemaining)"
                        result[3] = ""
                    } else {
                        result[0] = "Team A WON \(currentMatchScore) UP"
                        result[3] = ""
                    }
                case _ where currentMatchScore < 0:
                    if holesRemaining != 0 {
                        result[1] = "Team B WON \(-currentMatchScore) & \(holesRemaining)"
                        result[3] = ""
                    } else {
                        result[0] = "Team B WON \(-currentMatchScore) UP"
                        result[3] = ""
                    }
                default:
                    result = ["","","",""]
                    
                }
            }
    } //4BBB func
        
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
            
            let holesRemaining = 18 - holesPlayed
            let holesRemainingString = "with \(holesRemaining) holes remaining"
            
            
            
            // results when game still in play ie not at dormie or won/lost
            if currentMatchScore >= 0 && currentMatchScore < holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) < holesRemaining {
                
                
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
            // results when game at dormie
            if currentMatchScore >= 0 && currentMatchScore == holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) == holesRemaining {
                switch currentMatchScore {
                case 0:
                    result[2] = "Match halved"
                    result[3] = ""
                case _ where currentMatchScore > 0:
                    result[0] = "team A DORMIE \(currentMatchScore) UP"
                    result[3] = ""
                case _ where currentMatchScore < 0:
                    result[1] = "team B  DORMIE \(-currentMatchScore) UP"
                    result[3] = ""
                default:
                    result = ["","","",""]
                    
                }
            }
            //results when game won or lost
            if currentMatchScore >= 0 && currentMatchScore > holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) > holesRemaining {
                switch currentMatchScore {
                case _ where currentMatchScore > 0:
                    if holesRemaining != 0 {
                        result[0] = " Team A WON \(currentMatchScore) & \(holesRemaining)"
                        result[3] = ""
                    } else {
                        result[0] = " Team A WON \(currentMatchScore) UP"
                        result[3] = ""
                    }
                case _ where currentMatchScore < 0:
                    if holesRemaining != 0 {
                        result[1] = " Team B WON \(-currentMatchScore) & \(holesRemaining)"
                        result[3] = ""
                    } else {
                        result[0] = " Team B WON \(-currentMatchScore) UP"
                        result[3] = ""
                    }
                default:
                    result = ["","","",""]
                    
                }
            }
            
            
            
            
            
       } // fourball combined func
        
        func Foursomes(){
            let teamAScores = self.teamScoresArray.filter({$0.team == 0}).sorted(by: {$0.hole < $1.hole})
            let teamBScores = self.teamScoresArray.filter({$0.team == 1}).sorted(by: {$0.hole < $1.hole})
            
            for i in 0..<18 {
                   
                   switch self.AllScoresCommittedTeamAB(holeIndex: i){
                   case true:
                       holesPlayed += 1
                  
                       let teamANetLowScore = teamAScores[i].NetScoreMatch()
                       let teamBNetLowScore = teamBScores[i].NetScoreMatch()
                     
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
            let holesRemaining = 18 - holesPlayed
            let holesRemainingString = "with \(holesRemaining) holes remaining"
            
            // results when game still in play ie not at dormie or won/lost
            if currentMatchScore >= 0 && currentMatchScore < holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) < holesRemaining {
                
                
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
            // results when game at dormie
            if currentMatchScore >= 0 && currentMatchScore == holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) == holesRemaining {
                switch currentMatchScore {
                case 0:
                    result[2] = "Match halved"
                    result[3] = ""
                case _ where currentMatchScore > 0:
                    result[0] = "Team A DORMIE \(currentMatchScore) UP"
                    result[3] = ""
                case _ where currentMatchScore < 0:
                    result[1] = "Team B  DORMIE \(-currentMatchScore) UP"
                    result[3] = ""
                default:
                    result = ["","","",""]
                    
                }
            }
            //results when game won or lost
            if currentMatchScore >= 0 && currentMatchScore > holesRemaining || currentMatchScore <= 0 && (currentMatchScore * -1) > holesRemaining {
                switch currentMatchScore {
                case _ where currentMatchScore > 0:
                    if holesRemaining != 0 {
                        result[0] = "Team A WON \(currentMatchScore) & \(holesRemaining)"
                        result[3] = ""
                    } else {
                        result[0] = "Team A WON \(currentMatchScore) UP"
                        result[3] = ""
                    }
                case _ where currentMatchScore < 0:
                    if holesRemaining != 0 {
                        result[1] = "Team B WON \(-currentMatchScore) & \(holesRemaining)"
                        result[3] = ""
                    } else {
                        result[0] = "Team B WON \(-currentMatchScore) UP"
                        result[3] = ""
                    }
                default:
                    result = ["","","",""]
                    
                }
            }
        }
        
        switch currentGF.assignTeamGrouping {
      
            case .TeamC:
                result = ["","","",""]
            case .Indiv:
                switch currentGF.playFormat{
                            case .matchplay:
                                switch currentGF.noOfPlayersNeeded{
//
                                    case 3:// 6 point game
                                      SixPoint()
                                    default:
                                    result = ["","","",""]
                                    }
                            case .strokeplay:
                    result = ["","","",""]
                        }
            case .TeamsAB:
               
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
                        Foursomes()
                    case .strokeplay:
                        result = ["","","",""]
                    }
                case .TeamC:
                    result = ["","","",""]
              
            }
        }// the rest of this func applies the various game specific funcs to the appropriate game format
          
        return result
    }
}
