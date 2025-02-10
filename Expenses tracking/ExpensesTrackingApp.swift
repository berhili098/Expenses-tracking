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
  

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:[Expense.self])
        
    }
}
