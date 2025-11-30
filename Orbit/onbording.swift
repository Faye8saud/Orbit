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
            description: "شاهد . مهامك . بوضوح ",
            image: Image("image1")
        ),
        OnboardingPage(
            title: "زر طوارئ",
            description: "اسحب للخارج . لعرض كل مهامك ",
            image: Image("image2")
        ),
        OnboardingPage(
            title: "تذكيرات تناسبك",
            description: "هنا عن التذكيرات أو أي ميزة ثانية.",
            image: Image("image3")
        ),
        OnboardingPage(
            title: "جاهز نبدأ؟",
            description: "صفحة أخيرة تشجّع المستخدم يبدأ يستخدم التطبيق.",
            image: Image("image2")
        )
    ]
    
    @State private var currentPage: Int = 0
    
    private var lastIndex: Int {
        pages.count - 1
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
                TabView(selection: $currentPage) {
                    ForEach(pages.indices, id: \.self) { index in
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
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                            
                            Spacer()
                        }
                        .tag(index)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                Spacer()
                
                VStack(spacing: 20) {
                    
                    HStack(spacing: 8) {
                        ForEach(pages.indices, id: \.self) { index in
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
                    }
                    
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
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(Color("Background"))
                                        .padding(.trailing, 18)
                                }
                            }
                        }
                        .frame(width: 90, height: 90)
                        .shadow(color: Color("Color").opacity(0.25), radius: 10, x: 0, y: 2)
                        .opacity(currentPage == lastIndex ? 0 : 1)
                        .disabled(currentPage == lastIndex)
                    }
                    
                    if currentPage == lastIndex {
                        Button {
                            print("ابدأ التطبيق")
                          
                        } label: {
                            Text("ابدأ")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(Color("Color"))
                                .shadow(color: Color("Color").opacity(0.25), radius: 10, x: 0, y: 2)
                                .foregroundColor(.white)
                                .cornerRadius(40)
                            
                        }
                        .padding(.top, 2)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
