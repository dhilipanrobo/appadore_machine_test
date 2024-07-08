//
//  AboutGroup.swift
//  Appadore machine test
//
//  Created by Apple on 08/07/24.
//  Copyright © 2024 Dhilipan. All rights reserved.
//

import SwiftUI
import Kingfisher

struct AboutGroup: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isNavigation: Bool = false
    @EnvironmentObject var aboutController: AboutController
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
                            Button(action: {
                                isNavigation = true
                            }) {
                                HStack {
                                    Text("Edit")
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.white)
                                        .padding(.leading)
                                        .padding(.vertical, 2)
                                    Image("Vector")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 10.65, height: 10.65)
                                        .padding(.trailing)
                                        .padding(.vertical, 2)
                                }
                                .background(Color(.secondary))
                                .cornerRadius(14)
                                .padding(.trailing, 18)
                            }
                            Image("menu")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .padding(.trailing, 20)
                        }
                    }
                }
                
                VStack(alignment: .center) {
                    KFImage(URL(string: aboutController.groupPhoto))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .cornerRadius(10)
                    Text(aboutController.name)
                        .semiBoldStyle(color: .white)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    Text("Ignore shit people...")
                        .mediumStyle(color: .white, size: 12.92)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .padding(.top, 1)
                    HStack {
                        Image("VectorWhite")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        Text("\(aboutController.unread_count)")
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                            .padding(.trailing)
                    }
                    .padding(.top, 18)
                }
                .padding(.top, 36)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("About Group")
                            .semiBoldStyle(color: .primer)
                            .padding(.top, 42)
                            .padding(.leading, 34)
                        Spacer()
                    }
                    Text(aboutController.bio)
                        .normalStyle(color: .gray, size: 14)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 32)
                        .padding(.horizontal, 46)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(51, corners: [.topLeft, .topRight])
                .padding(.top, 16)
                .padding(.bottom, -40)
                
                NavigationLink(
                    destination: EditGroup(userEntity: userEntity),
                    isActive: $isNavigation,
                    label: { }
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.primer))
            .task {
                await aboutController.load(id: Int(userEntity.id))
            }
        }
        .navigationBarHidden(true)
    }
}

