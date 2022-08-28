//
//  ContentView.swift
//  PhotoCoreData
//
//  Created by App Designer2 on 22.08.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Saved.selectedImg, ascending: true)])
    private var saved: FetchedResults<Saved>

    @State private var selectedImg: Data = .init(count: 0)
    @State private var show: Bool = false
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(saved, id: \.id) { save in
                    VStack(alignment: .leading) {
                        
                        Image(uiImage: UIImage(data: save.selectedImg ?? self.selectedImg)!)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 24)
                            .cornerRadius(25)
                            .shadow(radius: 6)
                        
                        HStack(alignment: .top) {
                            
                            Text(save.name!)
                            
                            Spacer()
                            
                            Button(action: {
                                
                            }) {
                                Image(systemName: save.isLiked ? "bookmark.fill": "bookmark")
                                    .foregroundColor(save.isLiked ? .blue : .gray)
                            }
                        }
                    }
                }
                
            }
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.show.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }.sheet(isPresented: self.$show) {
                AddDataView().environment(\.managedObjectContext, self.viewContext)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
