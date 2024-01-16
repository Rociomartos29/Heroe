//
//  DragonBallHeroesTests.swift
//  DragonBallHeroesTests
//
//  Created by Rocio Martos on 28/12/23.
//

import XCTest

class AuthManagerTests: XCTestCase {
    
    func testLoginSuccess() {
        let authManager = AuthManager()
        
        // Simular una respuesta exitosa del servidor
        let expectation = XCTestExpectation(description: "Login successful")
        authManager.login(username: "user", password: "password") { success in
            XCTAssertTrue(success, "Login should be successful")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testLoginFailure() {
        let authManager = AuthManager()
        
        // Simular una respuesta fallida del servidor
        let expectation = XCTestExpectation(description: "Login unsuccessful")
        authManager.login(username: "invalidUser", password: "invalidPassword") { success in
            XCTAssertFalse(success, "Login should fail")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
}

class TransformationsManagerTests: XCTestCase {
    
    func testGetTransformationsSuccess() {
        let transformationsManager = TransformationsManager()
        
        // Simula una respuesta exitosa del servidor
        let expectation = XCTestExpectation(description: "Get transformations successful")
        transformationsManager.getTransformations(forHero: "heroID") { transformations in
            XCTAssertNotNil(transformations, "Transformations should not be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetTransformationsFailure() {
        let transformationsManager = TransformationsManager()
        
        // Simular una respuesta fallida del servidor
        let expectation = XCTestExpectation(description: "Get transformations unsuccessful")
        transformationsManager.getTransformations(forHero: "invalidHeroID") { transformations in
            XCTAssertNil(transformations, "Transformations should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    // Agregar más casos de prueba según sea necesario
}
