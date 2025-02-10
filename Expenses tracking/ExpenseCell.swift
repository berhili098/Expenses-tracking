//
//  ExpenseCell.swift
//  Expenses tracking
//
//  Created by Oussama Berhili on 10/2/2025.
//

import SwiftUI

struct ExpenseCell: View {
    let expense : Expense
    
    var body: some View {
        HStack{
            Text(expense.date, format: .dateTime.month(.abbreviated).day())
                .frame(width: 70 , alignment : .leading)
            Text(expense.name)
            Spacer()
            Text(expense.value, format: .currency(code: "USD"))
        }
    }
}

#Preview {
    ExpenseCell(
        expense: Expense(name: "Food", date: Date(), value: 20)
    )
}
