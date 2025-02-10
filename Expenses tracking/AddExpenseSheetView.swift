//
//  AddExpenseSheetView.swift
//  Expenses tracking
//
//  Created by Oussama Berhili on 10/2/2025.
//

import SwiftUI

struct AddExpenseSheetView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var date: Date = Date()
    @State private var value: Double = 0
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @Environment(\.modelContext) var context

    var isFormValid: Bool {
        return !name.trimmingCharacters(in: .whitespaces).isEmpty && value > 0
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense Name", text: $name)
                
                DatePicker("Date", selection: $date, displayedComponents: .date)
                
                TextField("Value", value: $value , formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        if isFormValid {
                            let expense = Expense(name: name, date: date, value: value)
                            context.insert(expense)
                            try? context.save()
                            dismiss()
                        } else {
                            showAlert = true
                            alertMessage = name.trimmingCharacters(in: .whitespaces).isEmpty
                                ? "Expense name cannot be empty."
                                : "Expense value must be greater than zero."
                        }
                    }
                    .disabled(!isFormValid)
                }
            }
            .alert("Invalid Input", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
}

#Preview {
    AddExpenseSheetView()
}
