//
//  LocationListView.swift
//  MapKitApp
//
//  Created by Atul Parmar on 04/04/25.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                
                Button {
                    vm.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
                
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    LocationListView()
        .environmentObject(LocationsViewModel())
}


extension LocationListView {
    
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .cornerRadius(10)
            }
            
            VStack (alignment: .leading){
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
