//
//  onbording.swift
//  Orbit
//
//  Created by Samar A on 08/06/1447 AH.
//
import SwiftUI

struct OnboardingView: View {
    
    struct OnboardingPage {
           let titleKey: String
           let descriptionKey: String
           let image: Image
       }
       
       private let pages: [OnboardingPage] = [
           OnboardingPage(
               titleKey: "",
               descriptionKey: "onboarding.page1.desc",
               image: Image("image1")
           ),
           OnboardingPage(
               titleKey: "",
               descriptionKey: "onboarding.page2.desc",
               image: Image("image2")
           )
       ]
    
    
    @State private var currentPage: Int = 0
      @State private var selectedThemeIndex: Int = 0
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
                  
                  // MARK: - Skip Button
                  HStack {
                      Spacer()
                      Button {
                          showCalendar = true
                      } label: {
                          Text(NSLocalizedString("onboarding.skip", comment: ""))
                              .font(.system(size: 18, weight: .regular))
                              .foregroundColor(.gray)
                      }
                  }
                  .padding(.top, 20)
                  .padding(.trailing, 20)
                  
                  
                  // MARK: - Pages View
                  TabView(selection: $currentPage) {
                      ForEach(0 ..< pages.count, id: \.self) { index in
                          
                          VStack(spacing: 20) {
                              Spacer()
                              
                              pages[index].image
                                  .resizable()
                                  .scaledToFit()
                                  .frame(height: 350)
                              
                              Text(NSLocalizedString(pages[index].titleKey, comment: ""))
                                  .font(.title)
                                  .bold()
                              
                              Text(NSLocalizedString(pages[index].descriptionKey, comment: ""))
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
                  
                  // MARK: - Bottom Navigation Controls
                  VStack(spacing: 20) {
                      
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
                      
                      // MARK: Buttons
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
                                  showCalendar = true
                              } label: {
                                  Text(NSLocalizedString("onboarding.start", comment: ""))
                                      .font(.system(size: 18, weight: .semibold))
                                      .frame(width: 200, height: 70)
                                      .background(Color("btnColor"))
                                      .foregroundColor(.white)
                                      .cornerRadius(50)
                                      .shadow(color: Color("btnColor").opacity(0.25),
                                              radius: 10, x: 0, y: 2)
                              }
                              .frame(maxWidth: .infinity, alignment: .center)
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
