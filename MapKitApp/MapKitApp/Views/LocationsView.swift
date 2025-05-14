//
//  LocationsView.swift
//  MapKitApp
//
//  Created by Atul Parmar on 04/04/25.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let maxWidthForIpad: CGFloat = 500
    
    var body: some View {
        
        ZStack {
            mapLayer
                .ignoresSafeArea(.all)
            
            VStack (spacing: 0) {
                header
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                Spacer()
                locationPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation, content: { location in
            LocationDetailView(location: location)
        })
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}


extension LocationsView {
    private var header: some View {
        VStack  {
            
            Button {
                vm.toggleLocationList()
            } label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                        
                    }
            }
            .tint(Color.primary)
                        
            if vm.showLocationList {
                LocationListView()
            }
            
            
        }
        .background(.thickMaterial)
        .cornerRadius(10, antialiased: true)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    
    //For below iOS 17
    
//    private var mapLayer: some View {
//        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations, annotationContent: { location in
//            //                    MapMarker(coordinate: location.coordinates, tint: .red)
//            MapAnnotation(coordinate: location.coordinates) {
//                LocationMapAnnotationView()
//                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
//            }
//        })
//        
//    }
    
    private var mapLayer: some View {
        Map(position: $vm.mapCameraPosition) {
            ForEach(vm.locations) { location in
                Annotation(location.name, coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.showNextLocation(location: location)
                        }
                }
            }
        }
    }
    
    private var locationPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
                
            }
        }

    }
    
}
