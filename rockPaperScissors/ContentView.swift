//
//  ContentView.swift
//  rockPaperScissors
//
//  Created by Margarita Usova on 20.07.2023.
//

import SwiftUI

struct ContentView: View {
//    @State private var computerMove = 0
    @State private var gameResult = "Нажмите на любую кнопку, чтобы начать игру"
    @State var userWins = 0
    @State var computerWins = 0
    @State private var computerMove = 0
    @State private var userWinner = true
    @State private var computerWinner = true
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .red], startPoint: .bottom, endPoint: .top).ignoresSafeArea()
            
            VStack{
                Text("Счет")
                    .font(.system(size: 50, weight: .bold, design: .default))
                    .foregroundColor(.white)
                HStack(spacing: 120){
                    
                    
                    
                    VStack{
                        scoreOutput(text: "Вы", color: userWinner ? .green : Color("loseColor"))
                        scoreOutput(text: String((userWins)), color: userWinner ? .green : Color("loseColor"))
                    }
                    VStack{
                        scoreOutput(text: "Компьютер", color: computerWinner ? .green : Color("loseColor"))
                        scoreOutput(text:(String(computerWins)), color: computerWinner ? .green : Color("loseColor"))
                    }
                    
                    
                }
                
                
                Button{
                    computerMove = Int.random(in: 1..<4)
                    
                    gameResult = play("🪨", computerMove: computerMove, computerWins: &computerWins, userWins: &userWins, computerWinner: &computerWinner, userWinner: &userWinner)
                    
                }
            label:{
                buttonView(emojiButton: "🪨", buttonColor:  Color("rockColor"))
                
            }
                
                Button{
                        computerMove = Int.random(in: 1..<4)
                    
                    gameResult = play("✂️", computerMove: computerMove, computerWins: &computerWins, userWins: &userWins, computerWinner: &computerWinner, userWinner: &userWinner)
                }
            label:{
                buttonView(emojiButton: "✂️", buttonColor: Color("scissorsColor"))
            }
                
                Button{
                    computerMove = Int.random(in: 1..<4)
                    
                    gameResult = play("📃", computerMove: computerMove, computerWins: &computerWins, userWins: &userWins, computerWinner: &computerWinner, userWinner: &userWinner)
                }
            label:{
                buttonView(emojiButton: "📃", buttonColor: Color("foneColor"))
            }
                Text(gameResult)
                    .foregroundColor(.white)
                    .font(.system(size: 19, weight: .bold, design: .default))
                
            
                Button{
                    userWins = 0
                    computerWins = 0
                    userWinner = true
                    computerWinner = true
                    gameResult = "Нажмите на любую кнопку, чтобы начать игру"
                }
            label:{
                Text("Начать сначала")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                    .frame(width: 180, height: 40)
                    .background(Color("startAgainColor"))
                    .cornerRadius(29)
            }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct buttonView: View {
    var emojiButton: String
    var buttonColor: Color
    var body: some View{
        Text(emojiButton)
            .font(.system(size: 80, weight: .bold, design: .default))
            .frame(width: 150, height: 150)
            .background(buttonColor.blur(radius: 70))
            .cornerRadius(50)
    }
}

func play(_ emoji: String, computerMove: Int, computerWins: inout Int, userWins: inout Int, computerWinner: inout Bool, userWinner: inout Bool)-> String{
    var move = ""
    switch computerMove{
    case 1:
        move = "🪨"
    case 2:
        move = "✂️"
    case 3:
        move = "📃"
    default:
        move = "📃"
    }
    
    
    if emoji == move {
        
        return "Ход компьютера " + String(move) +  "Ваш ход " + String(emoji) + "\n" + "Ничья!"
    }
    else if (emoji == "🪨" && move == "✂️") || (emoji == "✂️" && move == "📃") || (emoji == "📃" && move == "🪨"){
        userWins += 1
        getWinner(computerWins: &computerWins, userWins: &userWins, computerWinner: &computerWinner, userWinner: &userWinner)
        
        return "Ход компьютера: " + String(move) +  "Ваш ход: " + String(emoji) + "Вы выиграли!"
       
    }
    else {
        computerWins += 1
        getWinner(computerWins: &computerWins, userWins: &userWins, computerWinner: &computerWinner, userWinner: &userWinner)
        
        return "Ход компьютера: " + String(move) +  "Ваш ход: " + String(emoji) + "Вы прогирали!"
        
    }
}


struct scoreOutput: View {
    var text : String
    var color: Color
    var body: some View{
        Text(text)
            .font(.system(size: 30, weight: .bold, design: .default))
            .foregroundColor(color)
    }
}


func getWinner(computerWins: inout Int, userWins: inout Int, computerWinner: inout Bool, userWinner: inout Bool){
    if computerWins > userWins {
        computerWinner = true
        userWinner = false
                 }
     else if computerWins < userWins{
         computerWinner = false
         userWinner = true
     }
        else{
            computerWinner = true
            userWinner = true
        }
}
