//
//  MapView.swift
//  InfoDay
//
//  Created by e9207182 on 21/9/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region =
    MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 22.33787,
            longitude: 114.18131
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.005,
            longitudeDelta: 0.005
        )
    )
    
    var body: some View {
        ZStack(alignment:.bottom){
            Map(coordinateRegion: $region, annotationItems: Building.campusBuildings) { building in
                MapAnnotation(coordinate: building.coordinate) {
                    
                    Image(systemName: "mappin.circle.fill")
                        .resizable()
                        .frame(width: 30.0, height: 30.0)
                        .foregroundColor(Color(.systemRed))
                    Text(building.title)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 150)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .edgesIgnoringSafeArea(.top)
            
            Button("Reset") {
                withAnimation {
                    region.center = CLLocationCoordinate2D(
                        latitude: 22.33787,
                        longitude: 114.18131
                    )
                }
            }
            .padding()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

struct Building: Identifiable {
    
    var id = UUID()
    let title: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension Building {
    
    static let campusBuildings: [Building] = [
        Building(title: "AC Hall", latitude: 22.341280, longitude:
                    114.179768),
        Building(title: "Lam Woo International Conference Center", latitude:
                    22.337716, longitude: 114.182013),
        Building(title: "Communication and Visual Arts Building", latitude:
                    22.334382, longitude: 114.182528)
    ]
}
