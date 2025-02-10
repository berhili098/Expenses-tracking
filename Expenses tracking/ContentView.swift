//
//  ContentView.swift
//  Expenses tracking
//
//  Created by Oussama Berhili on 10/2/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @State private var isShowingItemSheet = false
    @Query(sort:\Expense.date)  var expenses : [Expense]
    @Environment(\.modelContext) var context
    
    func addExpenseSheet (){
      
    
    }

    var body: some View {
        NavigationStack{
            List {
                ForEach(expenses, id: \.id) { expense in
                    ExpenseCell(expense: expense)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let expense = expenses[index]
                        context.delete(expense)
                        
                    }
                }
            }.navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet){
                AddExpenseSheetView()
            }
            .toolbar{
                if !expenses.isEmpty {
                    Button("Add Expense", systemImage: "plus"){
                        isShowingItemSheet = true
                    }
                }
            }.overlay{
                if expenses.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No expenses", systemImage: "list.bullet.rectangle.portrait")
                    }, description:{
                        Text("You don't have any expenses yet")
                    }, actions: {
                        Button("Add Expense"){
                            isShowingItemSheet = true
                        }
                    }).offset(y: -60)
                }
            }
        }
        
    }

   
}

#Preview {
    ContentView()
}
