import SwiftUI

struct HomeView: View {
    
    @State var topSafeArea  = UIApplication.shared.windows.first?.safeAreaInsets.top
    
    @State var seleceFilter = HomeFilterEnum.newQuestion
    
    @Namespace var animation
    
    @State var isFilterShow = true
    
    @State var isBackgroundBlew = false
    
    
    var body: some View {
        ZStack(alignment: .top){
            ScrollView(.vertical,showsIndicators: false){
                GeometryReader { geo -> AnyView in
                    let minY = geo.frame(in: .global).minY
                    print(minY)
                    return AnyView(
                        VStack{
                            //프로필배경 & 프로필이미지
                            ZStack(alignment: .bottomLeading){
                                Image("backgroundImage")
                                    .resizable()
                                    .frame(height: minY > 0 ? 160+minY : 160)
                                    .ignoresSafeArea()
                                Image("profileImage")
                                    .resizable()
                                    .frame(width: 100,height: minY >= 0 ? 100 : 0)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(.white,lineWidth: 3))
                                    .offset(x:40,y: 50)
                            }
                            
                            
                            followButton
                            userDetail
                            Spacer()
                        }
                        .offset(y: minY > 0 ? -minY : 0)
                    )
                }
            }
            .ignoresSafeArea()
            navBar
        }
        
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


extension HomeView {
    var navBar : some View {
        
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
        
    }
    
    var profile : some View {
        
        ZStack(alignment: .bottomLeading){
            Image("backgroundImage")
                .resizable()
                .frame(height: 200)
                .ignoresSafeArea()
            Image("profileImage")
                .resizable()
                .frame(width: 100,height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(.white,lineWidth: 3))
                .offset(x:40,y: 50)
        }
    }
    
    var followButton : some View {
        HStack{
            Spacer()
            Button {
                print("follow!!")
            } label: {
                Image(systemName: "plus")
                Text("팔로우")
            }
            .font(.system(size: 20))
            .fontWeight(.bold)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(.orange)
            .cornerRadius(30)
        }
        .padding(.horizontal)
    }
    
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
    
    var filterBar : some View {
        HStack{
            ForEach(HomeFilterEnum.allCases, id:\.rawValue) { item in
                VStack{
                    if seleceFilter == item {
                        Text(item.title)
                            .fontWeight(.bold)
                        Capsule()
                            .foregroundColor(.blue)
                            .frame(height: 2)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    }else{
                        Text(item.title)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Capsule()
                            .foregroundColor(.clear)
                            .frame(height: 2)
                    }
                    
                }
                .onTapGesture {
                    withAnimation {
                        seleceFilter = item
                    }
                }
                
            }
        }
        .padding(.vertical, 4)
    }
}


struct BackgroundBlurView: UIViewRepresentable{
    func makeUIView(context: Context) -> some UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        
        DispatchQueue.main.async{
            view.superview?.superview?.backgroundColor = .clear
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
