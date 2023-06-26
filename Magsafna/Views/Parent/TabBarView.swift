// last copyyyyyyyy



//  TabBarView.swift
//  GPProject
//
//  Created by لجين إبراهيم الكنهل on 26/11/1444 AH.
//

import SwiftUI

// Remaining : colors, navigation for pages
struct TabBarView: View {
    
    @State var selectedTab: Tab = .home
    @State var  color: Color = .teal
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                case .profile:
                    ProfileParentView()
                case .writeInfo:
                    WriteToCard()
                case .library:
                    SwiftUIView()
                    
                }
            }
            .frame (maxWidth: .infinity, maxHeight: .infinity)
            HStack {
                ForEach(tabItems) { item in
                    Button {
                        withAnimation{
                            selectedTab = item.tab
                            color = item.color
                        }
                        
                    }label: {
                        VStack(spacing: 0) {
                        Image(systemName: item.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold() )
                                .frame(width: 44, height: 29)
                        Text (item.text)
                                .font(.caption2)
                                .lineLimit(1)
                        }
                        .frame (maxWidth: .infinity)
                    }
                    .foregroundStyle(selectedTab == item.tab ? .primary:
                            .secondary)
                    .blendMode(selectedTab == item.tab ? .overlay: .normal)
                         }
                        }
                    .padding(.horizontal)
                            .padding(.top)
                            .frame(height: 88, alignment: .top) .background (.ultraThinMaterial, in:
                        RoundedRectangle(cornerRadius: 34, style: .continuous))
                    .background(
                            HStack {
                                if selectedTab == .library { Spacer() }
                                if selectedTab == .profile { Spacer() }
                                if selectedTab == .writeInfo {
                                    Spacer ()
                                    Spacer ()
                           }
                            Circle().fill(color).frame (width: 100)
                            if selectedTab == .home {Spacer ()}
                            if selectedTab == .profile {
                                Spacer()
                                Spacer()
                              
                            }
                            if selectedTab == .writeInfo { Spacer() }
                        }
                                    .padding (.horizontal)
                    )
                    .overlay(
                            HStack {
                                
                                if selectedTab == .library { Spacer() }
                                if selectedTab == .profile { Spacer()}
                                if selectedTab == .writeInfo {
                                    Spacer ()
                                    Spacer ()
                           }
                            Rectangle()
                                    .fill(color)
                                    .frame (width: 28, height: 5)
                                    .cornerRadius(3)
                                    .frame(width: 88)
                                    .frame(maxHeight:.infinity,alignment: .top)
                                
                            if selectedTab == .home { Spacer() }
                            if selectedTab == .profile {
                                Spacer()
                                Spacer()
                               
                            }
                           if selectedTab == .writeInfo { Spacer() }
                        }
                            .padding(.horizontal)
                    )
                    //.StrokeStyle(cornerRadius: 34)
                    .frame (maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea ()
                
            
        }.navigationBarBackButtonHidden(true)
    }
}
        

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
