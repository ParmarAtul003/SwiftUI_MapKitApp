//
//  LocationMapAnnotationView.swift
//  MapKitApp
//
//  Created by Atul Parmar on 04/04/25.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    
    let accentColor = Color.accentColor
    
    var body: some View {
        VStack (spacing:0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .padding(6)
                .background(accentColor)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.red)
                .frame(width: 10, height: 10)
                .rotationEffect(.degrees(180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    ZStack {
        
        Color.black.ignoresSafeArea()
        
        LocationMapAnnotationView()
    }
}
