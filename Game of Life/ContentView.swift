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
    @State private var isDarkmode:Bool = true
    @State var isEditingStartBoard:Bool = false
    let cellSizeNormal:CGFloat = 15
    let cellSizeEdit: CGFloat = 30
    
    var body: some View {
        ZStack{
            Color("backgroundColor")
                .ignoresSafeArea()
            VStack{
                ZStack{
                    Text("Game of Life").textStyle(size: 25)
                    HStack{
                        Spacer()
                        Button {isDarkmode.toggle()}
                        label: {Image(systemName: isDarkmode ? "sun.max.fill" : "sun.max")
                                .foregroundStyle(Color("alive"))
                                .font(.title2)
                                .padding()
                        }
                    }
                }.padding(.horizontal)
                //Regular View
                if horizontalSizeClass == .regular{
                    HStack{
                        BoardView(label: "start", boardSize: logic.boardSize, boardContent: logic.initialBoard,cellSize: cellSizeNormal, maxHeight: 200, isEditable: logic.isEditable, onCellTap: {row, col in logic.toggleCell(row: row, column: col)
                        })
                        
                        BoardView(label: "generation \(logic.counter)", boardSize: logic.boardSize, boardContent: logic.newBoard, cellSize: cellSizeNormal, maxHeight: 200)
                    }
                    .padding()
                    Spacer()
                }
                //Compact View
                else{
                    VStack{
                        BoardView(label: "start", boardSize: logic.boardSize, boardContent: logic.initialBoard,cellSize: cellSizeNormal, maxHeight: 300)
                            .padding(5)
                        BoardView(label: "generation \(logic.counter)", boardSize: logic.boardSize, boardContent: logic.newBoard, cellSize: cellSizeNormal, maxHeight: 300)
                        Spacer()
                    }.fullScreenCover(isPresented: $isEditingStartBoard) {
                        EditStartBoardView(
                            boardSize: logic.boardSize,
                            boardContent: logic.initialBoard,
                            cellSize: cellSizeEdit,
                            maxHeight: 300,
                            isEditable: true,
                            onCellTap: { row, col in
                                logic.toggleCell(row: row, column: col)
                            }
                        )
                    }

                    
                }
                HStack{
                    Button("Start manually") {
                        logic.setStartManually()
                        isEditingStartBoard = true
                    }.customButtonStyle()
                    Button("Next generation") {
                        logic.nextGen()
                    }.customButtonStyle()
                    Button("Restart"){
                        logic.fillRandomly()
                        logic.calculateNext()
                        logic.counter=1
                    }.customButtonStyle()
                    
                   
                }
                
                
            }
            .preferredColorScheme(isDarkmode ? .dark: .light)
        }
        
    }
}

struct TextStyle: ViewModifier{
    var size: Double
    func body(content: Content) -> some View {
            content
            .foregroundStyle(Color("alive"))
            .font(.system(size: size, weight: .light, design: .serif))
            .italic()
        }
}

struct CustomButtonStyle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .buttonStyle(.plain)
            .padding(10)
            .background(Color("boxBackground"))
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
            .foregroundStyle(Color("alive"))
    }
}

extension View{
    func textStyle(size: Double) -> some View {
        self.modifier(TextStyle(size: size))
    }
    func customButtonStyle()->some View{
        self.modifier(CustomButtonStyle())
    }
}


struct BoardView: View {
    var label: String
    var boardSize: Int
    var boardContent: [[Int]]
    var cellSize:CGFloat
    var maxHeight: CGFloat
    var isEditable: Bool = false //has to be defined as false bc cant be optional parameter bc if needs a value
    var onCellTap: ((Int, Int) -> Void)? = nil
    
    var body: some View {
        GroupBox(label: Text(label).textStyle(size: 20)
            .frame(maxWidth: .infinity)){

            VStack(){
                ForEach(0..<boardSize, id: \.self) { row in
                    HStack(){
                        ForEach(0..<boardSize, id: \.self) { col in
                            Rectangle()
                                .fill(boardContent[row][col] == 1 ? Color("alive") : Color("dead"))
                                .frame(width: cellSize, height: cellSize)
                                .onTapGesture {
                                    if(isEditable){
                                        onCellTap?(row, col)
                                    }
                                }
                        }
                    }
                }
            }
        }
        .backgroundStyle(Color("boxBackground"))
        .frame(maxWidth: 300, maxHeight: maxHeight)
        
    }
}

struct EditStartBoardView:View {
    var boardSize: Int
    var boardContent: [[Int]]
    var cellSize:CGFloat
    var maxHeight: CGFloat
    var isEditable: Bool = false
    var onCellTap: ((Int, Int) -> Void)? = nil
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            Color("backgroundColor").ignoresSafeArea()
            VStack{
                Text("Start board").textStyle(size: 25)
                Spacer()
                BoardView(label: "", boardSize: boardSize, boardContent: boardContent, cellSize: cellSize, maxHeight: maxHeight, isEditable: true, onCellTap: onCellTap)
                Spacer(minLength: 10)
                Button("Done"){
                    dismiss()
                }.customButtonStyle()
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
