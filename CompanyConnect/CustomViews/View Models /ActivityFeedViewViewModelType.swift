//
//  ActivityFeedViewViewModelType.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

protocol ActivityFeedViewViewModelType {
    var currentPage: Int { get set }
    func selctedCategories() ->[Category]
    func categories() -> [Category]
    func hasSelectedCategories() -> Bool
    func presentedPosts() -> [ActvityPost]
    func resetSelectedCategories()
    func addToSelectedCategories(category: Category)
    func removeCategory(category: Category)
    func handleCategorySelection(_ category: Category)
    func loadPosts() async
}

protocol ActivityPostsServiceType {
    func getPosts(forPage page: Int) async throws -> ActivityFeedJSONResponse
}

@Observable
class OfflineActivityPostsService: ActivityPostsServiceType, HTTPDataDownloader {
    @MainActor
    func getPosts(forPage page: Int) async throws -> ActivityFeedJSONResponse {
        return try await getData(as: ActivityFeedJSONResponse.self, from: URLBuilder.activityFeed(page: "\(page)").url)
    }
}

@Observable
class OfflineActivityFeed: ActivityFeedViewViewModelType, ObservableObject {

    var currentPage = 1
    private (set) var service: ActivityPostsServiceType
    private var _posts = [ActvityPost]()
    private var _selctedCategories = [Category]()
    private var _categories: [Category] = []

    init(service: ActivityPostsServiceType) {
        self.service = service
    }

    func loadPosts() async {
        do {
            let response = try await service.getPosts(forPage: currentPage)
            print(response)
            currentPage = (response.page + 1)
            _posts.append(contentsOf: response.activityPosts)
        } catch {
            fatalError(error.localizedDescription) // Handle
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
    var currentPage = 1

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

    func loadPosts() async { }

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
    var currentPage = 1

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

    func loadPosts() async { }

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
    var currentPage = 1

    private var _posts = [ActvityPost]()
    private var _selctedCategories = [Category]()
    private var _categories: [Category] = [.community,.healthcare, .environmental, .education,.womensRights,.veterans, .humanRights,.indigenousRights]

    init() {
        for _ in 0..<50 {
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

    func loadPosts() async { }

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
