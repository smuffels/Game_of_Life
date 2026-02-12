//
//  ContentView.swift
//  Game of Life
//
//  Created on 04.04.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var logic = GameOfLifeLogic()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        if horizontalSizeClass == .regular{
            HStack{
                BoardView(label: "start", boardSize: logic.boardSize, boardContent: logic.oldBoard)
                BoardView(label: "next generation", boardSize: logic.boardSize, boardContent: logic.newBoard)
            }
            .padding()}
        else{
            VStack{
                BoardView(label: "start", boardSize: logic.boardSize, boardContent: logic.oldBoard)
                    .padding(5)
                BoardView(label: "next generation", boardSize: logic.boardSize, boardContent: logic.newBoard)
            }
            Spacer()
            
        }
        
    }
}

struct BoardView: View {
    var label: String
    var boardSize: Int
    var boardContent: [[Int]]
    
    var body: some View {
        GroupBox(label: Text(label).frame(maxWidth: .infinity)){
            VStack(){
                ForEach(0..<boardSize, id: \.self) { row in
                    HStack(){
                        ForEach(0..<boardSize, id: \.self) { col in
                            Rectangle()
                                .fill(boardContent[row][col] == 1 ? Color.pink : Color.white)
                                .frame(width: 15, height: 15)
                                .border(Color.gray)
                        }
                    }
                }
            }
        } .frame(maxWidth:300)
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    ContentView()
}
