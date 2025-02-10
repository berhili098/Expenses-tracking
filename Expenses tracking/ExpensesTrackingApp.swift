//
//  Expenses_trackingApp.swift
//  Expenses tracking
//
//  Created by Oussama Berhili on 10/2/2025.
//

import SwiftUI
import SwiftData

@main
struct ExpensesTrackingApp: App {
   
    var container: ModelContainer
    
    init() {
        let schema = Schema([Expense.self])
        do {
            container = try ModelContainer(for: schema, configurations: [])
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView() 
                .modelContainer(container)
        }
    }
}
