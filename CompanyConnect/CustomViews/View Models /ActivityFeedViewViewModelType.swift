//
//  ActivityFeedViewViewModelType.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

protocol ActivityFeedViewViewModelType {
    func selctedCategories() ->[Category]
    func categories() -> [Category]
    func hasSelectedCategories() -> Bool
    func presentedPosts() -> [ActvityPost]
    func resetSelectedCategories()
    func addToSelectedCategories(category: Category)
    func removeCategory(category: Category)
    func handleCategorySelection(_ category: Category)
}

protocol PostsServiceType {
    func getPosts() async throws -> [ActvityPost]
}

@Observable
class OfflinePostsService: PostsServiceType {
    let postCount: Int

    init(postCount: Int) {
        self.postCount = postCount
    }

    func getPosts() async throws -> [ActvityPost] {
        return Array(
            repeating: ActvityPost.createFakeActivityPost(),
            count: postCount
        )
    }
}

@Observable
class OfflineActivityFeed: ActivityFeedViewViewModelType, ObservableObject {

    private (set) var service: PostsServiceType
    private var _posts = [ActvityPost]()
    private var _selctedCategories = [Category]()
    private var _categories: [Category] = []

    init(service: PostsServiceType) {
        self.service = service
    }

    func loadPosts() async {
        do {
            self._posts = try await service.getPosts()
        } catch {
            // Handle Error
        }
    }

    func selctedCategories() -> [Category] {
        _selctedCategories
    }
    
    func categories() -> [Category] {
        Category.allCases
    }
    
    func hasSelectedCategories() -> Bool {
        !_selctedCategories.isEmpty
    }
    
    func presentedPosts() -> [ActvityPost] {
        _posts
    }
    
    func resetSelectedCategories() {
        _selctedCategories.removeAll()
    }
    
    func addToSelectedCategories(category: Category) {
        _selctedCategories.append(category)
    }
    
    func removeCategory(category: Category) {
        _selctedCategories.removeAll(where: { $0 == category })
    }
    
    func handleCategorySelection(_ category: Category) {
        if _selctedCategories.contains(category) {
            removeCategory(category: category)
        } else if !_selctedCategories.contains(category) {
            addToSelectedCategories(category: category)
        }
    }
}

@Observable // For Now
class CompanyActivityFeed: ActivityFeedViewViewModelType, ObservableObject {

    init(company: CompanyObject) {
        _company = company
        _posts = Array(repeating: ActvityPost.createFakeActivityPost(), count: 50)
    }

    private let _company: CompanyObject
    private var _posts: [ActvityPost]
    private var _selctedCategories = [Category]()
    private var _categories: [Category] = []

    private var _hasSelected: Bool {
        return !_selctedCategories.isEmpty
    }

    private var _presentedPosts: [ActvityPost] {
        _posts
    }

    func resetSelectedCategories() {
        _selctedCategories = []
    }

    func posts() -> [ActvityPost] {
        Array(repeating: ActvityPost.createFakeActivityPostForCompany(company: _company), count: 50)
    }

    func selctedCategories() -> [Category] {
        _selctedCategories
    }

    func categories() -> [Category] {
        _categories
    }

    func hasSelectedCategories() -> Bool {
        _hasSelected
    }

    func presentedPosts() -> [ActvityPost] {
        _presentedPosts
    }

    func addToSelectedCategories(category: Category) {
        _selctedCategories.append(category)
    }

    func removeCategory(category: Category) {
        _selctedCategories.removeAll(where: { $0 == category })
    }

    func handleCategorySelection(_ category: Category) {
        if _selctedCategories.contains(category) {
            removeCategory(category: category)
        } else if !_selctedCategories.contains(category) {
            addToSelectedCategories(category: category)
        }
    }

}

@Observable
class DevCompanyActivityFeed: ActivityFeedViewViewModelType, ObservableObject {

    init(company: CompanyObject) {
        _company = company
        _posts = Array(repeating: ActvityPost.createFakeActivityPost(), count: 50)
    }

    private let _company: CompanyObject
    private var _posts: [ActvityPost]
    private var _selctedCategories = [Category]()
    private var _categories: [Category] = []

    private var _hasSelected: Bool {
        return !_selctedCategories.isEmpty
    }

    private var _presentedPosts: [ActvityPost] {
        _posts
    }

    func resetSelectedCategories() {
        _selctedCategories = []
    }

    func posts() -> [ActvityPost] {
        _posts
    }

    func selctedCategories() -> [Category] {
        _selctedCategories
    }

    func categories() -> [Category] {
        _categories
    }

    func hasSelectedCategories() -> Bool {
        _hasSelected
    }

    func presentedPosts() -> [ActvityPost] {
        _presentedPosts
    }

    func addToSelectedCategories(category: Category) {
        _selctedCategories.append(category)
    }

    func removeCategory(category: Category) {
        _selctedCategories.removeAll(where: { $0 == category })
    }

    func handleCategorySelection(_ category: Category) {
        if _selctedCategories.contains(category) {
            removeCategory(category: category)
        } else if !_selctedCategories.contains(category) {
            addToSelectedCategories(category: category)
        }
    }

}

@Observable
class DevHomeTabActivityFeed: ActivityFeedViewViewModelType, ObservableObject {

    private var _posts = [ActvityPost]()
//    TweetGenerator.returnStructuredTweetList()
    private var _selctedCategories = [Category]()
    private var _categories: [Category] = [.community,.healthcare, .environmental, .education,.womensRights,.veterans, .humanRights,.indigenousRights]

    init() {

        for _ in 0..<50 {
            let company = CompanyObject.createFakeComapnyList().randomElement()!
            _posts.append(
                ActvityPost.createFakeActivityPost()
            )
        }
    }

    private var _hasSelected: Bool {
        return !_selctedCategories.isEmpty
    }

    private var _presentedPosts: [ActvityPost] {
        if _selctedCategories.isEmpty {
            return _posts
        }


        var tempArray = [ActvityPost]()
        for category in _selctedCategories {

            for post in _posts {
                if post.company.category == category {
                    tempArray.append(post)
                }
            }
        }

        return tempArray.sorted { post1, post2 in
            post1.date < post2.date
        }
    }

    func resetSelectedCategories() {
        _selctedCategories = []
    }

    func posts() -> [ActvityPost] {
        return _posts
    }

    func selctedCategories() -> [Category] {
        return _selctedCategories
    }

    func categories() -> [Category] {
        return _categories
    }

    func hasSelectedCategories() -> Bool {
        return _hasSelected
    }

    func presentedPosts() -> [ActvityPost] {
        return _presentedPosts
    }

    func addToSelectedCategories(category: Category) {
        _selctedCategories.append(category)
    }

    func removeCategory(category: Category) {
        _selctedCategories.removeAll(where: { $0 == category })
    }

    func handleCategorySelection(_ category: Category) {
        if _selctedCategories.contains(category) {
            removeCategory(category: category)
        } else if !_selctedCategories.contains(category) {
            addToSelectedCategories(category: category)
        }
    }

}
