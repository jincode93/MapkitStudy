//
//  ContentView.swift
//  OfficePlace
//
//  Created by 진준호 on 2022/11/05.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var placeStore: PlaceStore = PlaceStore(places: placeData)
    
    var body: some View {
        NavigationStack {
            Text("🏢 Company List 📱")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            List {
                ForEach(placeStore.places) { place in
                    NavigationLink {
                        PlaceDetailView(place: place)
                    } label: {
                        VStack {
                            AsyncImage(url: URL(string: place.imageUrl)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .aspectRatio(contentMode: .fit)
                            .padding()
                            .frame(height: 150)
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
