//
//  APIClient+UserTests.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

import Foundation
import Testing
@testable import RandomUserApi

@Suite struct APIClientUserTests {
    @Suite struct Success {
        @Test func getWithValidPageReturnsResourceWithURL() throws {
            // Arrange
            let page = 1
            let seed = "testSeed"

            // Act
            let resource = try UserResponse.get(page: page, seed: seed)

            // Assert
            #expect(resource.url.absoluteString != nil)
        }

        @Test func getWithoutSeedGeneratesRandomSeed() throws {
            // Arrange
            let page = 1

            // Act
            let resource = try UserResponse.get(page: page)

            // Assert
            let urlString = resource.url.absoluteString
            #expect(urlString.contains("page=\(page)"))
            #expect(urlString.contains("seed="))
        }

        @Test func generateRandomSeekCreatesValidRandomSeed() {
            // Act
            let seed = UserResponse.generateRandomSeek

            // Assert
            #expect(seed.count == 16)
            #expect(seed.range(of: "^[0-9a-f]+$", options: .regularExpression) != nil)
        }

        @Test func resourceURLHasCorrectPathAndQuery() throws {
            // Arrange
            let page = 1
            let seed = "testSeed"

            // Act
            let resource = try UserResponse.get(page: page, seed: seed)

            // Assert
            #expect(resource.url.absoluteString.contains("page=\(page)"))
            #expect(resource.url.absoluteString.contains("seed=\(seed)"))
        }
    }

    @Suite struct Failure {
        @Test func withInvalidURLThrowsBadUrlError() throws {
            // Arrange
            let page = -1 // Página inválida

            // Act & Assert
            do {
                let _ = try UserResponse.get(page: page)
            } catch {
                #expect(((error as? NetworkError) == .badUrl))
            }
        }
    }
}
