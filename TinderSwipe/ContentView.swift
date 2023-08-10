//
//  ContentView.swift
//  TinderSwipe
//
//  Created by Nirmit Patel on 09/08/23.
//

import SwiftUI

struct ContentView: View {
    var names:[String] = ["name1", "name2", "name3", "name4","name5", "name6"]
    var body: some View {
        VStack {
            ZStack {
                ForEach(names, id: \.self) { name in
                    CardView(name: name)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private struct CardView: View {
    var name: String
    @State private var offset = CGSize.zero
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width:320, height:320)
                .border(.white, width: 6.0)
                .cornerRadius(4)
                .foregroundColor(.black.opacity(0.9))
                .shadow(radius: 4)
            HStack {
                Text(name)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .offset(x: offset.width, y: offset.height*0.4)
        .rotationEffect(.degrees(Double(offset.width/40)))
        .gesture(
            DragGesture()
                .onChanged({ gesture in
                    offset = gesture.translation
                })
                .onEnded({ _ in
                    withAnimation {
                        swipeCard(x: offset.width)
                    }
                })
        )
    }
    
    func swipeCard(x: CGFloat) {
        switch x {
        case -500 ... -150:
            offset = CGSize(width: -500, height: 0)
        case 150 ... 500:
            offset = CGSize(width: 500, height: 0)
        default:
            offset = CGSize.zero
        }
    }
}
