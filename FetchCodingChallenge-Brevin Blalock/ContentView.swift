//
//  ContentView.swift
//  FetchCodingChallenge-Brevin Blalock
//
//  Created by Brevin Blalock on 6/8/24.
//

import SwiftUI

struct ContentView: View {
    let url: String = "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg"
    var body: some View {
        NavigationView {
            List {
                Text("Desserts")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                ForEach(1..<28) { item in
                    NavigationLink { DessertDetailView() } label: {
                        HStack {
                            AsyncImage(url: URL(string: url)) { image in
                                image.image?
                                    .resizable()
                                    .scaledToFit()
                            }
                            .frame(width: 80, height: 80)
                            .cornerRadius(20)
                            .padding(.trailing, 20)
                            
                            Text("Apple & Blackberry Crumble")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.yellow)
                        }
                        
                    }
                    
                    .listRowSeparator(.hidden)
                }
            }
            .frame( maxWidth: .infinity)
            .listStyle(.plain)
        }
    }
}

struct DessertDetailView: View {
    
    var instructions = """
    Heat oven to 190C/170C fan/gas 5. Tip the flour and sugar into a large bowl. Add the butter, then rub into the flour using your fingertips to make a light breadcrumb texture. Do not overwork it or the crumble will become heavy. Sprinkle the mixture evenly over a baking sheet and bake for 15 mins or until lightly coloured.\r\nMeanwhile, for the compote, peel, core and cut the apples into 2cm dice. Put the butter and sugar in a medium saucepan and melt together over a medium heat. Cook for 3 mins until the mixture turns to a light caramel. Stir in the apples and cook for 3 mins. Add the blackberries and cinnamon, and cook for 3 mins more. Cover, remove from the heat, then leave for 2-3 mins to continue cooking in the warmth of the pan.\r\nTo serve, spoon the warm fruit into an ovenproof gratin dish, top with the crumble mix, then reheat in the oven for 5-10 mins. Serve with vanilla ice cream.
"""
    
    var body: some View {
        VStack() {
            Text("Apple & Blackberry Crumble")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.yellow)
            
            
            ScrollView {
                TextEditor(text: .constant(instructions))
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: false)
                    .multilineTextAlignment(.leading)
                    .frame(height: 300)
                    .padding()
                    .lineSpacing(5)
                    
            }
            .frame(height: 200)
            
            VStack(alignment: .leading) {
                Text("Ingredients and Measurements:")
                    .padding(.bottom, 20)
                ForEach(1..<10) {_ in
                    Text("Plain Flour: 120g")
                        .padding(.bottom, 5)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
