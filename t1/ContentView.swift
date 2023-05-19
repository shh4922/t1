//
//  ContentView.swift
//  t1
//
//  Created by Hyeonho on 2023/05/14.
//

import SwiftUI

struct ContentView: View {
    
    //top dege value
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var current = "house"
    @Namespace var animation
    
    @State var isHide = false
    
    var body: some View {
        VStack(spacing: 0){
            
            //AppBar + filterButton
            VStack(spacing: 22){
                if !isHide {
                    HStack(spacing: 12){
                        Text("FaceBook")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.blue)
                        Spacer()
                        Button {
                            print("!!")
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .padding()
                                .background(.black.opacity(0.1))
                                .clipShape(Circle())
                        }
                        Button {
                            print("!!")
                        } label: {
                            Image(systemName: "message.fill")
                                .foregroundColor(.black)
                                .padding()
                                .background(.black.opacity(0.1))
                                .clipShape(Circle())
                        }

                    }
                    .padding(.horizontal)
                }
                //Tabbar
                HStack(spacing: 0){
                    TabbarButton(current: $current, image: "house", animation: animation)
                    TabbarButton(current: $current, image: "magnifyingglass", animation: animation)
                    TabbarButton(current: $current, image: "person.2.fill", animation: animation)
                    TabbarButton(current: $current, image: "tv.fill", animation: animation)
                }
            }
            .padding(.top,top)
            .padding(.top, 50)
            .background(.white)
            
            //Content
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing: 0){
                    
                    // georeader get location
                    GeometryReader{ geo -> AnyView in
                        let yAxis = geo.frame(in: .global).minY
                        
                        print(yAxis)
                        
                        if yAxis < 0 && !isHide{
                            DispatchQueue.main.async {
                                withAnimation {
                                    isHide = true
                                }
                            }
                        }
                        if yAxis > 0 && isHide{
                            DispatchQueue.main.async {
                                withAnimation {
                                    isHide = false
                                }
                            }
                        }
                        return AnyView(
                            Text("")
                                .frame(width: 0,height:0)
                        )
                    }
                    .frame(width: 0,height:0)
                    
                    VStack(spacing: 15){
                        ForEach(1...20, id:\.self){ i in
                            VStack(spacing: 10){
                                
                                HStack(spacing: 10){//유저 셀
                                    
                                    Image(systemName: "house.fill")
                                        .resizable()
                                        .frame(width: 35,height: 35)
                                        .padding(5)
                                        .background(.orange.opacity(0.3))
                                        .clipShape(Circle())
                                    
                                    VStack{
                                        Text("난 신현호")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                        Text("\(45-i) Min")
                                        
                                    }
                                    Spacer(minLength: 0)
                                }
                                Text("안녕 나는 현호라고해 안녕 안녕 슈바아알!!!!ㅁㄴㅇㅁㄴㅇㅁㄴㅇ")
                            }
                            .padding()
                            .background(.white)
                        }
                    }
                }
                .padding(.top)
            }
        }
        .background(Color(uiColor: .systemGray5))
        .ignoresSafeArea()
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
