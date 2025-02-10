//
//  UpdateExpenseSheetView.swift
//  Expenses tracking
//
//  Created by Oussama Berhili on 10/2/2025.
//

import SwiftUI

struct UpdateExpenseSheetView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var expense : Expense
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @Environment(\.modelContext) var context
  
    

    var isFormValid: Bool {
        return !expense.name.trimmingCharacters(in: .whitespaces).isEmpty && expense.value > 0
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense Name", text: $expense.name)
                
                DatePicker("Date", selection: $expense.date, displayedComponents: .date)
                
                TextField("Value", value: $expense.value , formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
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
    UpdateExpenseSheetView(
        expense: Expense(name: "Food", date: Date(), value: 20)
    )
}
