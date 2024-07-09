//
//  EditGroupView.swift
//  Appadore machine test
//
//  Created by Apple on 08/07/24.
//  Copyright © 2024 Dhilipan. All rights reserved.
//

import SwiftUI
import Kingfisher

struct EditGroup: View {
    
    @State private var nameText: String = ""
    private let characterLimit = 50
    @State private var aboutText: String = ""
    @Environment(\.presentationMode) var presentationMode
    let coreDataManager = CoreDataManager()
    var userEntity: UserEntity
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        VStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image("arrow")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                            }
                            .padding(.leading, 34)
                        }
                        .padding(.top, 8)
                        Spacer()
                        HStack {
                            Image("menu")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .padding()
                        }
                    }
                }
                
                VStack(alignment: .center) {
                    KFImage(URL(string: userEntity.group_photo ?? ""))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .cornerRadius(10)
                }
                .padding(.top, 4)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Name")
                            .semiBoldStyle(color: .primer)
                            .padding(.top, 42)
                            .padding(.leading, 34)
                        
                        TextField("", text: $nameText)
                            .overlay(
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(Color(.systemGray4)),
                                alignment: .bottom
                            )
                            .onChange(of: nameText) { newValue in
                                if newValue.count > characterLimit {
                                    nameText = String(newValue.prefix(characterLimit))
                                }
                            }
                            .padding(.horizontal,36)
                        
                        HStack {
                            Spacer()
                            Text("\(nameText.count) / \(characterLimit) ")
                                .normalStyle(color: .black, size: 12)
                        }
                        .padding(.trailing, 26)
                        
                        Text("About Group")
                            .semiBoldStyle(color: .primer)
                            .padding(.top, 42)
                            .padding(.leading, 34)
                        
                        VStack {
                            TextEditor(text: $aboutText)
                                .font(.system(size: 14))
                                .submitLabel(.done)
                                .frame(height: 115, alignment: .top)
                                .lineLimit(3)
                                .cornerRadius(22)
                                .multilineTextAlignment(.leading)
                                .colorMultiply(Color(.systemGray5))
                        }
                        .padding(.horizontal, 32)
                        .padding(.top, 22)
                    }
                    .padding(.top, 45)
                    
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Cancel")
                                .foregroundColor(.red)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red, lineWidth: 1)
                                )
                                .cornerRadius(10)
                        }
                        Button(action: {
                            userEntity.name = nameText
                            userEntity.bio = aboutText
                            coreDataManager.updateUser()
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Save")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding(30)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(51, corners: [.topLeft, .topRight])
                .padding(.top, 16)
                .padding(.bottom, -40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.primer))
            .task {
                nameText = userEntity.name ?? ""
                aboutText = userEntity.bio ?? ""
            }
        }
        .navigationBarHidden(true)
    }
}

