//
//  ColorIconView.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 22/11/2022.
//

import SwiftUI

struct ColorIconView: View {
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .mint, .cyan, .blue, .indigo, .purple, .pink, .brown, .gray]
    
    @Binding var selectedColor: Color // a) binding variable from ListView, b) preview update with .constant
    
    var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 20) {
            GridRow {
                ForEach(0..<colors.count/2, id: \.self) { idx in
                    Button(action: {
                        print("clicked \(colors[idx])")
                        selectedColor = colors[idx]

                    }, label: {
                        Label("", systemImage: "circle.fill")
                            .foregroundColor(colors[idx])
//                                    .font(.title)
                    })
                }
            }
            GridRow {
                // To get rid off message: Non-constant range: argument must be an integer literal -> use id: \.self
                ForEach(colors.count/2..<colors.count, id: \.self) { idx in
                    Button(action: {
                        print("clicked \(colors[idx])")
                        selectedColor = colors[idx]

                    }, label: {
                        Label("", systemImage: "circle.fill")
                            .foregroundColor(colors[idx])
//                                    .font(.title)
                    })
                }
            }
            
        }
        .frame(maxWidth: .infinity)
            .padding(10)
            .background(.white)
//            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .font(.title)



    }
}

struct ColorIconView_Previews: PreviewProvider {
    static var previews: some View {
        ColorIconView(selectedColor: .constant(.blue)) //creates a binding with an immutable value
    }
}
