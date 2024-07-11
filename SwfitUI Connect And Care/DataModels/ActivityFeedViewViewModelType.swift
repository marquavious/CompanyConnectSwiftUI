//
//  ActivityFeedViewViewModelType.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

protocol ActivityFeedViewViewModelType {
    func posts() -> [ActvityPost]
    func selctedCategories() ->[Category]
    func categories() -> [Category]
    func hasSelected() -> Bool
    func presentedPosts() -> [ActvityPost]
    func resetSelectedCategories()
    func addToSelectedCategories(category: Category)
    func removeCategory(category: Category)
}

@Observable
class CompanyActivityFeed: ActivityFeedViewViewModelType, ObservableObject {

    init(company: CompanyObject) {
        _posts = TweetGenerator.generateRandomTweetsFrom(company: company)
    }

    private var _posts: [ActvityPost]
    private var _selctedCategories = [Category]()
    private var _categories: [Category] = []

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
            post1.hourAgoPosted < post2.hourAgoPosted
        }
    }

    func resetSelectedCategories() {
        _selctedCategories = []
    }

    func posts() -> [ActvityPost] {
        return ActvityPost.makeFakeActivityPosts()
    }

    func selctedCategories() -> [Category] {
        return _selctedCategories
    }

    func categories() -> [Category] {
        return _categories
    }

    func hasSelected() -> Bool {
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

}

@Observable
class BasicFakeActivityFeed: ActivityFeedViewViewModelType, ObservableObject {

    private var _posts = TweetGenerator.returnStructuredTweetList()
    private var _selctedCategories = [Category]()
    private var _categories: [Category] = [.community,.healthcare, .environmental, .education,.womensRights,.veterans, .humanRights,.indigenousRights]
//    CompanyObject.ceateFakeComapnyList().map{ $0.category }
//    Category.createCategoryList().sorted { $0.name < $1.name }

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
            post1.hourAgoPosted < post2.hourAgoPosted
        }
    }

    func resetSelectedCategories() {
        _selctedCategories = []
    }

    func posts() -> [ActvityPost] {
        return ActvityPost.makeFakeActivityPosts()
    }

    func selctedCategories() -> [Category] {
        return _selctedCategories
    }

    func categories() -> [Category] {
        return _categories
    }

    func hasSelected() -> Bool {
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

}

