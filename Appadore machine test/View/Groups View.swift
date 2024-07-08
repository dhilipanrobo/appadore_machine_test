//
//  Groups_View.swift
//  Appadore machine test
//
//  Created by Apple on 07/07/24.
//  Copyright © 2024 Dhilipan. All rights reserved.
//

import SwiftUI
import Kingfisher

struct Groups_View: View {
    @EnvironmentObject var groupsController: GroupsController
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text("GROUPS")
                            .boldStyle(color: .white)
                            .padding(.leading, 26)
                        Spacer()
                        Image("tabler_search")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .padding()
                        Image("menu")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .padding()
                    }
                }
                Spacer()
                VStack {
                    ScrollView {
                        ForEach(groupsController.userEntity, id: \.self) { user in
                            NavigationLink(destination: AboutGroup(userEntity: user).environmentObject(AboutController())) {
                                CardView(
                                    title: user.name ?? "",
                                    description: user.bio ?? "",
                                    imageUrl: user.group_photo ?? "",
                                    participantCount: Int(user.participant_count ),
                                    unreadCount: Int(user.unread_count ),
                                    userStatus: user.user_status ?? ""
                                )
                            }
                            .padding(.top, -8)
                        }
                    }
                    .padding(.top, 28)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(51, corners: [.topLeft, .topRight])
                .padding(.bottom, -40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.primer))
            .task {
                await groupsController.getUserLoad()
            }
        }
    }
}

#Preview {
    Groups_View()
}

