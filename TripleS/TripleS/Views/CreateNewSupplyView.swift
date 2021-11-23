//
//  CreateNewSupplyView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 04.11.2021.
//

import SwiftUI

struct CreateNewSupplyView: View {
    
    @State var Name: String = ""
    @State var Description: String = ""
    @State var ShelfLife: String = ""
    @State var Amount: String = ""
    @State var Unit: String = ""
    
    @State var isDone = false
    
    var complition: (Supply?) -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            TextField("Product name", text: $Name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title)
            TextField("Product description", text: $Description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title)
            TextField("Shelf Life", text: $ShelfLife)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title)
            TextField("Amount", text: $Amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title)
            TextField("Unit", text: $Unit)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title)
            Spacer()
            Button (action: {
                Add()
            }) {
                Text("Add")
                    .font(.title)
            }
            .alert(isPresented: $isDone) {
                // 2 вот тут вместо алерта должны происходить какие то вещи
                Alert(title: Text("New product created"),
                      message: Text("You successfully added new product to warehouse, now back to work"),
                      dismissButton: .default(Text("Ok")))
            }
            Spacer()
        }.padding()
    }
    
    private func Add() {
        //1- здесь должено быть добавление, делается вызов комплишена, хз пока как это интегрировать по уму
        //here will be server request
//        newProduct = Supply(id: UUID(), product: Product(name: Name, description: Description, unit: TripleS.Unit(rawValue: Unit) ?? .pc, shelfLife: Double(ShelfLife) ?? 0), productionDate: Date(), amount: Double(Amount) ?? 0)
        complition(Supply(id: UUID(), product: Product(name: Name, description: Description, unit: TripleS.Unit(rawValue: Unit) ?? .pc, shelfLife: Double(ShelfLife) ?? 0), productionDate: Date(), amount: Double(Amount) ?? 0))
        isDone.toggle()
        ClearAllFields()
    }
    
    private func ClearAllFields() {
        Name = ""
        Description = ""
        Unit = ""
        Amount = ""
        ShelfLife = ""
    }
}

struct CreateNewSupplyView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewSupplyView() { _ in
            
        }
    }
}
