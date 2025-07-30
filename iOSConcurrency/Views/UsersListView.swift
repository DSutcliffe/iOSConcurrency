//
//  UsersListView.swift
//  iOSConcurrency
//
//  Created by Daniel Sutcliffe on 30/07/2025.
//

import SwiftUI

struct UsersListView: View {
//    @StateObject private var viewModel = UsersListViewModel()
#warning("This is a preview only view. It will not call the actual API endpoint, Use line above when shipping to App Store!")
    @StateObject private var viewModel = UsersListViewModel(forPreview: false) // #if DEBUG... added to VM to stop calling actual endpoint
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users) { user in
                    NavigationLink {
                        PostsListView(userId: user.id)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.title)
                            Text(user.email)
                        }
                    }
                    
                }
            }
            /// Code for Progress Spinner
            .overlay(content: {
                if viewModel.isLoading {
                    ProgressView()
                }
            })
            .alert("Application Error", isPresented: $viewModel.showAlert, actions: {
                Button("OK") {}
            }, message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            })
            .navigationTitle("Users")
            .listStyle(.plain)
            .onAppear {
                viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    UsersListView()
}

//struct UsersListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UsersListView()
//    }
//}
