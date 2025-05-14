//
//  LocationsViewModel.swift
//  MapKitApp
//
//  Created by Atul Parmar on 04/04/25.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    //All Loaded location
    @Published var locations: [Location] = []
    
    //Current location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    //Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    @Published var mapCameraPosition:MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion())
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    //Show list of location
    @Published var showLocationList: Bool = false
    
    // Show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
    init () {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: mapLocation)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
            mapCameraPosition = MapCameraPosition.region(MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan
            ))
        }
    }
    
    func toggleLocationList() {
        withAnimation (.easeInOut){
            self.showLocationList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation (.easeInOut){
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonPressed() {
        //Get the current index
        //Method 1
//        let currentIndex = locations.firstIndex { location in
//            return location == mapLocation
//        }
        
        //Method 2
        //let currentIndex = locations.firstIndex(of: mapLocation)!
        
        //Method 3
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation}) else {
            print( "Could not find index")
            return
        }
               
        //Method 1
        //let nextIndex = (currentIndex + 1) % locations.count
        
        //Method 2
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            //Next inde is not valid and restart with 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        //Next index is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
