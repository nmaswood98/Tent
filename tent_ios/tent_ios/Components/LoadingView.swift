//
//  LoadingView.swift
//  tent_ios
//
//  Created by Nabhan Maswood on 11/15/19.
//  Copyright © 2019 Nabhan Maswood. All rights reserved.
//

import SwiftUI


struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView<Content>: View where Content: View {
    @EnvironmentObject var loadingService: LoadingViewService
    
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Color.clear
                self.content()
                    .disabled(self.loadingService.showLoadingDialog)
                    .blur(radius: self.loadingService.showLoadingDialog ? 3 : 0)
                
                VStack {
                    Text(self.loadingService.loadingMessage)
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                    .background(Color.secondary.colorInvert())
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                    .opacity(self.loadingService.showLoadingDialog ? 1 : 0)
                
            }
        }
    }
    
}
