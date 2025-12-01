//
//  onbording.swift
//  Orbit
//
//  Created by Samar A on 08/06/1447 AH.
//

import SwiftUI
     
struct OnboardingView: View {
    
    private let pages: [OnboardingPage] = [
        OnboardingPage(
            title: "",
            description: " See  •  Your Tasks  •  Clearly",
            image: Image("image1")
        ),
        OnboardingPage(
            title: "",
            description: "Swipe out to  •  view all  •  your tasks clearly",
            image: Image("image2")
        ),
        OnboardingPage(
            title: "Got an emergency?",
            description: "Tap to send  •  an apology",
            image: Image("image3")
        )
    ]
    
    @State private var currentPage: Int = 0
    @State private var selectedThemeIndex: Int = 4
    
    private var lastIndex: Int {
        pages.count   
    }
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            Image("Background1")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea(edges: .bottom)
            
            VStack {
                HStack{
                    Spacer()
                    Text("Skip")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.gray)
                        .underline(true,color: .gray.opacity(0.6))
                }
                .padding(.top,20)
                .padding(.trailing,20)
                TabView(selection: $currentPage) {
                    ForEach(0 ..< pages.count + 1, id: \.self) { index in
                        
                        if index < pages.count {
                            VStack(spacing: 20) {
                                Spacer()
                                
                                pages[index].image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 350)
                                
                                Text(pages[index].title)
                                    .font(.title)
                                    .bold()
                                
                                Text(pages[index].description)
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.medium)

                                
                                Spacer()
                            }
                            .tag(index)
                        } else {
                            LastOnboardingView(selectedThemeIndex: $selectedThemeIndex)
                                .tag(index)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                Spacer()
                
                VStack(spacing: 20) {
                    
                    HStack(spacing: 8) {
                        ForEach(0 ..< pages.count + 1, id: \.self) { index in
                            Button {
                                currentPage = index
                            } label: {
                                Capsule()
                                    .frame(
                                        width: currentPage == index ? 30 : 10,
                                        height: 12
                                    )
                                    .foregroundColor(
                                        currentPage == index ? Color("Color1") : .gray.opacity(0.4)
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.bottom,30)
                    }
                    
                    if currentPage != lastIndex {
                        HStack {
                            Spacer()
                            
                            Button {
                                if currentPage < lastIndex {
                                    currentPage += 1
                                }
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                    
                                    Circle()
                                        .fill(Color("Color"))
                                    
                                    HStack {
                                        Spacer()
                                        Image("arrow")
                                            .renderingMode(.template)
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(Color("Background"))
                                            .frame(width: 60, height: 60)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                        
                                    }
                                }
                            }
                            .frame(width: 90, height: 90)
                            .shadow(color: Color("Color").opacity(0.25),
                                    radius: 10, x: 0, y: 2)
                        }
                    }else{
                        HStack{
                            Spacer()
                            Button("Start"){
                                
                                print("start")
                                
                            }
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 200,height: 70)
                            .background(Color("Color"))
                            .foregroundColor(.white)
                            .cornerRadius(50)
                            .shadow(color: Color("Color").opacity(0.25),
                                    radius: 10, x: 0, y: 2)
                        }
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            }
        }
    }
}


#Preview {
    OnboardingView()
}
