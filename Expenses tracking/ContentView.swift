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
    @State private var isShowingItemSheetUpdate = false
    @Query(filter: #Predicate<Expense>{$0.value > 1000}, sort:\Expense.date , animation: .bouncy)  var expenses : [Expense]
    @Environment(\.modelContext) var context
    @State private var expenseToEdit : Expense?
    
    func addExpenseSheet (){
      
    
    }

    var body: some View {
        NavigationStack{
            List {
                ForEach(expenses, id: \.id) { expense in
                    ExpenseCell(expense: expense)
                        .onTapGesture {
                            expenseToEdit = expense 
                        }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let expense = expenses[index]
                        context.delete(expense)
                        
                    }
                }
            }.navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet){AddExpenseSheetView()}
            .sheet(item: $expenseToEdit){ expense in
                
                    UpdateExpenseSheetView(expense: expense)
                    
                
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
