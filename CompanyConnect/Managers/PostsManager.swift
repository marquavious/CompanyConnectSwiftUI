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
    private (set) var categoryManager: CategoryManager

    var filteredPosts: [Post] {
        if !categoryManager.hasSelectedCategories {
            return allPosts
        }

        // TODO: - Optimize
        var tempArray = [Post]()
        for category in categoryManager.selctedCategories {

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

    /**
     Sets all posts in the manager.

      - Warning: This function will replace ALL current posts. If you
     want to append, use `appendPosts(posts: [Post])`
     instead.
    */
    func setPosts(posts: [Post]) {
        allPosts = posts
    }

    func appendPosts(posts: [Post]) {
        allPosts.append(contentsOf: posts)
    }

    init(posts: [Post] = [], categoryManager: CategoryManager = CategoryManager()) {
        self.categoryManager = categoryManager
        self.allPosts = posts
    }
}
