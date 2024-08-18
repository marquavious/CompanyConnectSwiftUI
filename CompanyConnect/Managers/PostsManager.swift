//
//  PostsManager.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/18/24.
//

import Foundation

@Observable
class PostsManager: ObservableObject {

    private (set) var allPosts: [Post]
    private (set) var categoryFilter: CategoryManager

    var filteredPosts: [Post] {
        if !categoryFilter.hasSelectedCategories {
            return allPosts
        }

        var tempArray = [Post]()
        for category in categoryFilter.selctedCategories {

            for post in allPosts {
                if post.company.category == category {
                    tempArray.append(post)
                }
            }
        }

        return tempArray.sorted { post1, post2 in
            post1.date < post2.date
        }
    }

    func setPosts(posts: [Post]) {
        allPosts = posts
    }

    init(posts: [Post] = [], categoryFilter: CategoryManager = CategoryManager()) {
        self.categoryFilter = categoryFilter
        self.allPosts = posts
    }
}
