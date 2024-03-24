//
//  ContentView.swift
//  MiniGithubApp
//
//  Created by Josue Lubaki on 2024-03-23.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel : ProfileViewModel = .init()
    
    var body: some View {
        VStack(spacing : 20) {
            AsyncImage(url: URL(string: viewModel.user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(.circle)
            } placeholder: {
                Circle()
                     .foregroundColor(.secondary)
                    
            }
            .frame(width: 120, height: 120)

            
            Text(viewModel.user?.login ?? "")
                .bold()
                .font(.title3)
            
            Text(viewModel.user?.bio ?? "")
                .padding()
            
            Spacer()
        }
        .padding()
    }
}


struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
