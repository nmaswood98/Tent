//
//  InfoView.swift
//  UIMockUps
//
//  Created by Nabhan Maswood on 1/23/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI
import CoreLocation

struct InfoView: View {
    var body: some View {
        VStack{
            Text("Current Tent: 1234")
                .foregroundColor(.green)
                .font(.title)
                .padding(.top,50)
            MapView2(currentPosition: CLLocationCoordinate2D(latitude: 0, longitude: 0), circleRadius: 0)
                .cornerRadius(20)
                .frame(height:300)
                .padding()
            Text("Tent Closes in:\n 1 Hour 20 Minutes")
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.green)

            Spacer()
            Text("Leave Tent")
                .foregroundColor(.green)

            Spacer()
            

        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
