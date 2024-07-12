//
//  CardView.swift
//  Appadore machine test
//
//  Created by Apple on 08/07/24.
//  Copyright © 2024 Dhilipan. All rights reserved.
//

import SwiftUI
import Kingfisher

struct CardView: View {
    var title: String
    var description: String
    var imageUrl: String
    var participantCount: Int
    var unreadCount: Int
    var userStatus : String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    HStack{
                        Text(title)
                            .semiBoldStyle(size: 16.15)
                        Text(userStatus)
                            .normalStyle(color: .white, size: 10.15)
                                        .foregroundColor(.white)
                                        .padding(2)
                                        .background(.primer)
                                        .cornerRadius(4)
                    }
                    Text(description)
                        .mediumStyle(color:.gray.opacity(0.8),size: 12.92)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Image("users")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        
                        Text("\(Double(participantCount).formattedAsCurrency)")
                            .multilineTextAlignment(.leading)
                            .padding(.trailing)
                    }
                    
                    Text("\(unreadCount)")
                        .font(.caption)
                        .foregroundColor(.white)
                        .frame(width: 22, height: 22)
                        .background(Color(.primer))
                        .clipShape(Circle())
                        .padding(4)
                        .background(Color(.primer))
                        .clipShape(Circle())
                }.padding(.top, 16)
            }
            
            Divider()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .padding([.top, .horizontal])
    }
}

