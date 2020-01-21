//
//  TentHistoryView.swift
//  UIMockUps
//
//  Created by Nabhan Maswood on 1/20/20.
//  Copyright © 2020 Nabhan Maswood. All rights reserved.
//

import SwiftUI

struct TentHistoryView: View {
    var body: some View {
        ZStack{
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 4)
            
                MapView()
                    .cornerRadius(30)
                         
            VStack{
                ZStack{
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width:80,height:40)
                        .cornerRadius(5)
                    Text("1234")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                }


            }
            
            
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    

                    }
                    .padding(.trailing,15)
                    .padding([.bottom],10)
            }
            
        }
        .frame(width:150,height: 150)
    }
}

struct TentHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.gray
        VStack(spacing:15){
            HStack(spacing:15){
                TentHistoryView()
                TentHistoryView()

            }
            HStack(spacing:15){
                TentHistoryView()
                TentHistoryView()

            }
            HStack(spacing:15){
                TentHistoryView()
                TentHistoryView()

            }

        }
        }
    }
}
