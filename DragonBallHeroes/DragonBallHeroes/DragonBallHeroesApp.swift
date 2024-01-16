//
//  DragonBallHeroesApp.swift
//  DragonBallHeroes
//
//  Created by Rocio Martos on 28/12/23.
//

import SwiftUI
import UIKit

struct LoginViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LoginViewController {
        return LoginViewController()
    }

    func updateUIViewController(_ uiViewController: LoginViewController, context: Context) {
        // Puedes realizar actualizaciones si es necesario
    }
}

struct ContentView: View {
    var body: some View {
        // Usa el envoltorio de la vista del controlador de vista de UIKit
        LoginViewControllerWrapper()
    }
}

@main
struct DragonBallHeroesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
