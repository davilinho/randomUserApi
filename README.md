# Random User API Test

[![OS Version: iOS 18.2](https://img.shields.io/badge/iOS-18.2-red.svg)](https://www.apple.com/es/ios/ios-18/)

In this document, the main details of the development, the application Swift iOS test, using the Random User Generator tool. A free, open-source API for generating random user data. Like Lorem Ipsum, but for people.

## Project target

The main objective of the project is to show a clean, tested and simple architecture, based on a [Random User API](https://randomuser.me/documentation), where a simple master-detail will be shown, with basic functions such as: list, paginate, search and show detail.

![Demo](https://github.com/davilinho/randomUserApi/blob/master/demo.gif)

## Architecture and design pattern

As the main architecture of the project, we have used the MVVM pattern.

### Technologies used
- MVVM design pattern
- [Swift 6](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/)
- [SwiftUI](https://developer.apple.com/documentation/swiftui/)
- [SwiftData](https://developer.apple.com/documentation/swiftdata/)
- [Strict concurrency](https://developer.apple.com/documentation/swift/adoptingswift6)
- [View Inspector for UI Testing as a third library](https://github.com/nalexn/ViewInspector)
  
## Testsing

### Unit tests

Unit tests are tests of isolated components or business logic using mock objects. Therefore, as a general basis, at the very least every view model, use case, repository and datasource should include unit tests when using the MVVM architecture. 

## Branching strategy

In order to illustrate our usage of good practices in Git, we used a variant of [GitFlow]([https://datasift.github.io/gitflow/IntroducingGitFlow.html](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)) during this assignment. In pure GitFlow, a feature is implemented in a single branch named `feature/name-of-feature`.

I always merged my changes using pull requests.