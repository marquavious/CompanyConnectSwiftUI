//
//  ActivityFeedViewViewModelType.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

protocol ActivityFeedViewViewModelType {
//    var loadingState: LoadingState { get }
//    var service: ActivityPostsServiceType { get set }
//    func presentedPosts() -> [ActvityPost]
//    func selctedCategories() ->[Category]
//    func categories() -> [Category]
//    func hasSelectedCategories() -> Bool
//    func resetSelectedCategories()
//    func addToSelectedCategories(category: Category)
//    func removeCategory(category: Category)
//    func handleCategorySelection(_ category: Category)
//    func loadPosts() async
}

@Observable
class OfflineActivityFeed: ActivityFeedViewViewModelType, ObservableObject {
    var loadingState: LoadingState = .loading
    var service: ActivityPostsServiceType = OfflineActivityPostsService()
    private var _posts = [ActivityPost]()
    private var _selctedCategories = [Category]()
    private var _categories: [Category] = []

    func loadPosts() async {
        loadingState = .loading
        do {
            let response = try await service.getPosts()
            _posts.append(contentsOf: response.activityPosts)
            loadingState = .fetched
        } catch {
            let nsError = error as NSError
            if nsError.domain == NSURLErrorDomain,
                nsError.code == NSURLErrorCancelled {
                //Handle cancellation
            } else {
                loadingState = .error(error)
            }
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
    
    func presentedPosts() -> [ActivityPost] {
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
    var currentPage = 0
    var loadingState: LoadingState = . loading
    var service: ActivityPostsServiceType

    init(companyID: String, service: ActivityPostsServiceType) {
        _posts = Array(repeating: ActivityPost.createFakeActivityPost(), count: 50)
        self.service = service
    }

    private var _posts = [ActivityPost]()
    private var _selctedCategories = [Category]()
    private var _categories: [Category] = []

    private var _hasSelected: Bool {
        return !_selctedCategories.isEmpty
    }

    private var _presentedPosts: [ActivityPost] {
        _posts
    }

    func resetSelectedCategories() {
        _selctedCategories = []
    }

    func loadPosts() async { }

    func posts() -> [ActivityPost] {
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

    func presentedPosts() -> [ActivityPost] {
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
    var loadingState: LoadingState = .fetched
    var service: ActivityPostsServiceType = DevActivityPostsService()

    private var _posts = Array(repeating: ActivityPost.createFakeActivityPost(), count: 50)
    private var _selctedCategories = [Category]()
    private var _categories: [Category] = []

    private var _hasSelected: Bool {
        return !_selctedCategories.isEmpty
    }

    private var _presentedPosts: [ActivityPost] {
        _posts
    }

    func resetSelectedCategories() {
        _selctedCategories = []
    }

    func loadPosts() async { }

    func posts() -> [ActivityPost] {
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

    func presentedPosts() -> [ActivityPost] {
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

extension Encodable {
    var prettyPrintedJSONString: String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        encoder.keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? encoder.encode(self) else { return nil }
        return String(data: data, encoding: .utf8) ?? nil
    }
}

@Observable
class DevHomeTabActivityFeed: ActivityFeedViewViewModelType, ObservableObject {
    var service: ActivityPostsServiceType = DevActivityPostsService()

    private var _posts = [ActivityPost]()
    private var _selctedCategories = [Category]()
    private var _categories: [Category] = [.community, .healthcare, .environmental, .education, .womensRights, .veterans, .humanRights, .indigenousRights]
    var loadingState: LoadingState

    init(postCount: Int = 50, loadingState: LoadingState = .fetched) {
        self.loadingState = loadingState
        for _ in 0..<postCount {
            _posts.append(
                ActivityPost.createFakeActivityPost()
            )
        }
    }

    private var _hasSelected: Bool {
        return !_selctedCategories.isEmpty
    }

    private var _presentedPosts: [ActivityPost] {
        return _posts

        /*
        For now....
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
        */
    }

    func resetSelectedCategories() {
        _selctedCategories = []
    }

    func loadPosts() async { }

    func posts() -> [ActivityPost] {
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

    func presentedPosts() -> [ActivityPost] {
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
