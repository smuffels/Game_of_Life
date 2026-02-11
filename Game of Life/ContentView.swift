//
//  ContentView.swift
//  Game of Life
//
//  Created by Celine Brun on 04.04.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var logic = GameOfLifeLogic()
    var body: some View {
        HStack{
            GroupBox(label: Text("old")) {
                VStack(){
                    ForEach(0..<logic.size, id: \.self) { row in
                        HStack(){
                            ForEach(0..<logic.size, id: \.self) { col in
                                Rectangle()
                                    .fill(logic.oldBoard[row][col] == 1 ? Color.pink : Color.white)
                                    .frame(width: 15, height: 15)
                                    .border(Color.gray)
                            }
                        }
                    }
                }
        }
            GroupBox(label: Text("new")) {
                VStack(){
                    ForEach(0..<logic.size, id: \.self) { row in
                        HStack(){
                            ForEach(0..<logic.size, id: \.self) { col in
                                Rectangle()
                                    .fill(logic.newBoard[row][col] == 1 ? Color.pink : Color.white)
                                    .frame(width: 15, height: 15)
                                    .border(Color.gray)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
