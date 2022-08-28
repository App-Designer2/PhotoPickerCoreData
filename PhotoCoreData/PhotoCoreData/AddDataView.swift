//
//  AddDataView.swift
//  PhotoCoreData
//
//  Created by App Designer2 on 22.08.22.
//

import SwiftUI
import PhotosUI

// To access to the new PhotoPicker, we have to import its Framework [ PhotosUI ]
struct AddDataView: View {
    
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var selectedImg: Data = .init(count: 0)
    @State private var selectedItems: [PhotosPickerItem] = []
    
    var body: some View {
        NavigationView {
            
            Form {
                HStack {
                    Spacer()
                //MARK: PhotoPicker
                PhotosPicker(selection: $selectedItems,
                             maxSelectionCount: 1,
                             matching: .images) {
                    if selectedItems.count != 0 {
                        if let data = selectedImg, let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                                .shadow(radius: 5)
                            
                        }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)
                            .shadow(radius: 5)
                            .foregroundColor(.gray)
                        
                    }
                }//MARK: PhotoPicker
                Spacer()
            }//MARK: HStack
                
                .onChange(of: selectedItems) { new in
                    guard let items = selectedItems.first else { return
                        
                    }//MARK: items
                    
                    items.loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let data):
                            if let data = data {
                                self.selectedImg = data
                            } else {
                                print("No data :(")
                            }
                        case .failure(let error):
                            fatalError("\(error)")
                        }
                    }//MARK: loadTransferable
                    
                }//MARK: onChange
                
                TextField("Name...", text: self.$name)
                
                HStack {
                    Spacer()
                    Button(action: {
                        
                        //MARK: Lets add data to the database( CoreData )
                        
                        let new = Saved(context: self.moc)
                        new.id = UUID()
                        new.name = self.name
                        new.selectedImg = self.selectedImg
                        
                        //MARK: Lets save the data permanently
                        try! self.moc.save()
                        
                        //MARK: Lets dismiss the AdddataView
                        dismiss()
                        
                        self.name = ""
                        self.selectedImg.count = 0
                    }) {
                        Text("Save")
                    }.buttonStyle(.borderedProminent)
                        .disabled(self.name.count > 2 && self.selectedImg.count != 0 ? false : true)
                    Spacer()
                }
            }//MARK: Form
        }
    }
}

struct AddDataView_Previews: PreviewProvider {
    static var previews: some View {
        AddDataView()
    }
}


//MARK: for some reazon we cant pick photo on the simulator, you have to run your app on physical device!!!


//MARK: this is the way we used photopicker to save photos on the database [ CoreData ] <3
//See you
