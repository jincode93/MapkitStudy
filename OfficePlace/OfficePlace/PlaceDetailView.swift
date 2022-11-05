//
//  PlaceDetailView.swift
//  OfficePlace
//
//  Created by 진준호 on 2022/11/05.
//

import SwiftUI
import MapKit

struct PlaceDetailView: View {
    @State private var isShowingSheet = false
    
    let place: Place
    
    var body: some View {
        List {
            AsyncImage(url: URL(string: place.imageUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            
            Text("\(place.name)")
                .bold()
            VStack(alignment: .leading) {
                Text("채용 사이트")
                    .bold()
                
                Button(action: {
                    isShowingSheet.toggle()
                }) {
                    Text(place.siteUrl)
                        .lineLimit(1)
                }
            }
            
            VStack(alignment: .leading) {
                NavigationLink {
                    MapDetailView(place: place)
                } label: {
                    VStack(alignment: .leading) {
                        MapDetailView(place: place)
                            .frame(height: 200)
                        Text("지도보기")
                            .bold()
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingSheet, onDismiss: didDismiss) {
            WebSheetView(url: place.siteUrl)
        }
    }
    
    func didDismiss() {
        
    }
}

struct AnnotatedItem: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct MapDetailView: View {
    let place: Place
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.008))
    
    @State private var annotatedItems: [AnnotatedItem] = []
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: annotatedItems) { item in
                MapMarker(coordinate: item.coordinate, tint: .blue)
            }
        }
        .onAppear {
            let coordinate = CLLocationCoordinate2D(latitude: place.lat, longitude: place.long)
            region.center = coordinate
            
            let annotatedItem = AnnotatedItem(name: place.name, coordinate: coordinate)
            annotatedItems.append(annotatedItem)
        }
    }
}

struct WebSheetView: View {
    let url: String
    
    var body: some View {
        SafariView(url: URL(string: url)!)
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView(place: placeData.last!)
    }
}
