//
//  ContentView.swift
//  Game of Life
//
//  Created on 04.04.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var logic = GameOfLifeLogic()
    var body: some View {
        HStack{
            BoardView(label: "old", boardSize: logic.boardSize, boardContent: logic.oldBoard)
            BoardView(label: "new", boardSize: logic.boardSize, boardContent: logic.newBoard)
        }
        .padding()
        
    }
}

struct BoardView: View {
    var label: String
    var boardSize: Int
    var boardContent: [[Int]]
    var body: some View {
        GroupBox(label: Text(label)) {
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
    }
    }
}

#Preview {
    ContentView()
}
