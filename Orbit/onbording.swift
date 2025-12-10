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
            description: "See  •  Your Tasks  •  Clearly",
            image: Image("image1")
        ),
        OnboardingPage(
            title: "",
            description: "Swipe out • view all • tasks clearly",
            image: Image("image2")
        )
    ]
    
    @State private var currentPage: Int = 0
    @State private var showCalendar: Bool = false
    
    private var lastIndex: Int {
        pages.count - 1
    }
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            Image("Background1")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .bottom)
                .ignoresSafeArea(edges: .bottom)
            
            VStack {
                // MARK: - Skip
                HStack {
                    Spacer()
                    Button {
                        NotificationManager.shared.requestAuthorizationIfNeeded()
                        showCalendar = true
                    } label: {
                        Text("Skip")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, 20)
                .padding(.trailing, 20)
                
                TabView(selection: $currentPage) {
                    ForEach(0 ..< pages.count, id: \.self) { index in
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
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                            
                            Spacer()
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                Spacer()
                
                VStack(spacing: 20) {
                    
                    // Dots
                    HStack(spacing: 8) {
                        ForEach(0 ..< pages.count, id: \.self) { index in
                            Capsule()
                                .frame(
                                    width: currentPage == index ? 30 : 10,
                                    height: 12
                                )
                                .foregroundColor(
                                    currentPage == index
                                    ? Color("Color")
                                    : .gray.opacity(0.4)
                                )
                                .onTapGesture {
                                    currentPage = index
                                }
                        }
                    }
                    .padding(.bottom, 30)
                    
                    if currentPage != lastIndex {
                        HStack {
                            Spacer()
                            
                            Button {
                                if currentPage < lastIndex {
                                    currentPage += 1
                                }
                            } label: {
                                ZStack {
                                    Circle().fill(.ultraThinMaterial)
                                    Circle().fill(Color("btnColor"))
                                    
                                    Image("arrow")
                                        .renderingMode(.template)
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color("background"))
                                        .frame(width: 40, height: 40)
                                }
                            }
                            .frame(width: 80, height: 80)
                            .shadow(color: Color("btnColor").opacity(0.25),
                                    radius: 10, x: 0, y: 2)
                        }
                    } else {
                        HStack {
                            Spacer()
                            
                            Button {
                                NotificationManager.shared.requestAuthorizationIfNeeded()
                                showCalendar = true
                            } label: {
                                Text("Start")
                                    .font(.system(size: 18, weight: .semibold))
                                    .frame(width: 200, height: 70)
                                    .background(Color("btnColor"))
                                    .foregroundColor(.white)
                                    .cornerRadius(50)
                                    .shadow(color: Color("btnColor").opacity(0.25),
                                            radius: 10, x: 0, y: 2)
                            }
                            
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 10)
            }
        }
        .fullScreenCover(isPresented: $showCalendar) {
            NavigationStack {
                mainHomeView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        OnboardingView()
    }
}
