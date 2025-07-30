//
//  PostsListView.swift
//  iOSConcurrency
//
//  Created by Daniel Sutcliffe on 30/07/2025.
//

import SwiftUI

struct PostsListView: View {
//    @StateObject var viewModel = PostsListViewModel()
#warning("This is a preview only view. It will not call the actual API endpoint, Use line above when shipping to App Store!")
    @StateObject var viewModel = PostsListViewModel(forPreview: true) // #if DEBUG... added to VM to stop calling actual endpoint
    var userId: Int?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.posts) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .onAppear {
                viewModel.userId = userId
                viewModel.fetchPosts()
            }
        }
    }
}

#Preview {
    PostsListView(userId: 1)
}

//struct PostsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            PostsListView(userId: 1)
//        }
//    }
//}
