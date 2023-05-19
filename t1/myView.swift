//
//  myView.swift
//  t1
//
//  Created by Hyeonho on 2023/05/18.
//

import SwiftUI

struct myView: View {
    @State var topSafeArea  = UIApplication.shared.windows.first?.safeAreaInsets.top
    
    var body: some View {
        VStack {
            navBar
            profile
            userDetail
            Spacer()
        }
    }
}

struct myView_Previews: PreviewProvider {
    static var previews: some View {
        myView()
    }
}

extension myView {
    
    var userDetail : some View {
        VStack (alignment: .leading,spacing: 6){
            Text("나는 시발 개쩌는 신현호다!")
                .font(.title2)
                .fontWeight(.heavy)
            Text("@똥마려운현호")
                .font(.caption)
                .foregroundColor(.gray)
            Text("나는 개쩌는 신현호인데, 킄크크크르를크크")
                .font(.system(size: 18))
                .fontWeight(.light)
            // follower & following
            HStack {
                HStack{
                    Text("315")
                        .font(.system(size: 20).bold())
                    Text("팔로워")
                }
                HStack{
                    Text("287")
                        .font(.system(size: 20).bold())
                    Text("팔로잉")
                }
            }
            
            // I know You know friends
            HStack{
                HStack(spacing: -5){
                    Circle()
                        .frame(width: 20,height: 20)
                        .foregroundColor(.red)
                    Circle()
                        .frame(width: 20,height: 20)
                        .foregroundColor(.blue)
                    Circle()
                        .frame(width: 20,height: 20)
                        .foregroundColor(.green)
                }
                Text("공공칠빵 으악!,공공칠빵 으악!,공공칠빵 으악!,공공칠빵 으악!,공공칠빵 으악! 님 외 29명")
                    .font(.caption)
            }
            
            //question & answer & reject
            HStack{
                VStack{
                    Text("1.5K")
                        .fontWeight(.bold)
                    Text("받은 질문 수")
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                }
                Spacer()
                VStack{
                    Text("1.5K")
                        .fontWeight(.bold)
                    Text("새 질문")
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                }
                Spacer()
                VStack{
                    Text("1.5K")
                        .fontWeight(.bold)
                    Text("오늘 방문자 수")
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding(.horizontal)
    }
    
    var navBar : some View {
        VStack{
            HStack(spacing: 20){
                Image(systemName: "arrow.left")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color(uiColor: .systemGray2))
                    .clipShape(Circle())
                Spacer()
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color(uiColor: .systemGray2))
                    .clipShape(Circle())
                Image(systemName: "list.bullet")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color(uiColor: .systemGray2))
                    .clipShape(Circle())
                
            }
            .padding(.horizontal)
            .padding(.top,topSafeArea)
            .padding(.top,50)
        }
    }
    
    var profile : some View {
        GeometryReader {geo -> AnyView in
            
            let minY = geo.frame(in: .global).minY
            
            print(minY)
            return AnyView(
                ZStack(alignment: .bottomLeading){
                    Image("backgroundImage")
                        .resizable()
                        .frame(height: minY > 0 ? 160+minY : 160)
                        .ignoresSafeArea()
                    
                    if minY < -25 {
                        
                    }
                    Image("profileImage")
                        .resizable()
                        .frame(width: minY < -25 ? 0 : 100,height: minY < -25 ? 0 : 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.white,lineWidth: 3))
                        .offset(x:40,y: 50)
                }
                    .offset(y: minY > 0 ? -minY : 0)
                
            )
        }
        .frame(height: 160)
        
    }
    
}

