//
//  WarehouseView.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 03.11.2021.
//

import SwiftUI

struct WarehouseView: View {
    @State var dataSupplies: [Supply] = []
    @State var loadedSupplies: [Supply] = []
    @State var isLoading = false
    
    @State var isDataParsed: Bool = false {
        didSet {
            dataSupplies = loadedSupplies
            loadedSupplies = []
        }
    }
    
    var body: some View {
        if isDataParsed {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Product").font(.title2)
                    Spacer(minLength: 90)
                    Text("Amount").font(.title2)
                    Spacer(minLength: 50)
                    Text("Shelf Life").font(.title2)
                }.padding()
                Spacer()
                List {
                    ForEach(dataSupplies) { supply in
                        HStack {
                            Text(supply.product.name)
                            Spacer()
                            Text(String(supply.amount))
                            Text(supply.product.unit.rawValue)
                            Spacer()
                            Text(String(supply.product.shelfLife))
                        }
                    }
                }
                .navigationTitle("Warehouse")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: CreateNewSupplyView() {
                            dataSupplies.append($0!)
                        }, label: {
                            Image(systemName: "plus.viewfinder").font(.title)
                        })
                    }
                }
            }
        } else {
            VStack(alignment: .center) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(3)
                        .navigationTitle("Warehouse")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    updateData()
                                }, label: {
                                    Image(systemName: "arrow.clockwise")
                                })
                            }
                        }
                } else {
                    Spacer()
                        .onAppear {
                            updateData()
                        }
                }
            }
        }
        
    }
    
    private func updateData() {
        isLoading = true
        isDataParsed = false
        loadData {
            (data, error) in
            data?.forEach { item in
                loadedSupplies.append(item)
            }
            isLoading = false
            isDataParsed = true
        }
    }
}

//Here will be loading data from API
func loadData(completion: @escaping ([Supply]?, Error?)->Void) {
    completion(testData, nil)
}

let testData:[Supply] = [Supply(id: UUID(), product: Product(name: "FirstProd", description: "nice first product, long description, really long", unit: .kg, shelfLife: 5), productionDate: Date(), amount: 25.5),
                         Supply(id: UUID(), product: Product(name: "SecondProd", description: "nice second product, long description, really long", unit: Unit(rawValue: "ml") ?? .ml, shelfLife: 4), productionDate: Date(), amount: 28.5),
                         Supply(id: UUID(), product: Product(name: "ThirdProd", description: "nice third product, long description, really long", unit: .kg, shelfLife: 7), productionDate: Date(), amount: 12.5),
                         Supply(id: UUID(), product: Product(name: "ForthProd", description: "nice forth product, long description, really long", unit: .kg, shelfLife: 5), productionDate: Date(), amount: 2.5),
                         Supply(id: UUID(), product: Product(name: "FifthProd", description: "nice fifth product, long description, really long", unit: .pc, shelfLife: 50), productionDate: Date(), amount: 5)]

struct WarehouseView_Previews: PreviewProvider {
    static var previews: some View {
        WarehouseView()
    }
}
