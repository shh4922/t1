import SwiftUI

struct GeoTest: View {

    @State var topSafeArea  = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var TopImageHeight : CGFloat = 180
    @State var offset : CGFloat = 0
    
    @State var seleceFilter = HomeFilterEnum.newQuestion
    @Namespace var animation
    
    func getOffset() -> CGFloat{
        //스크롤을 아래로 내일다 -> offset이 늘어남
        if offset > 0 {
            return -offset
        }
        //스크롤을 위로 올린다 -> offset이 줄어듬
        
        
        
        //하지만 특정offset부터는 사이즈를 유지해야함.
        return 0
    }
    
    func getHeightTop() -> CGFloat {
        print(offset)
        if offset > 0{
            return TopImageHeight + offset
        }
        if offset < -20 {
            return 140 - offset
        }
        if offset < 0 {
            //어차피 offset은 -니깐  그냥 더하면됌.
            return TopImageHeight + offset
        }
        return 180
    }
    
    func getNavBarOffset() -> CGFloat{
        if offset > 0 {
            return -offset
        }
        if offset < -10 {
            return -offset - 10
        }
        if offset < 0 {
            return offset
        }
        return 0
    }
    
    func getTitleOpacity() -> CGFloat {
        if offset < 0 {
            return -offset / 100
        }
        return 0
    }
    
    var body: some View {
        GeometryReader{ proxy in
            ScrollView(.vertical,showsIndicators: false){
                VStack{
                    //navBar를 보여주기위해서
                    ZStack(alignment: .top){
                        VStack{
                            GeometryReader{ geo  -> AnyView in
                                let minY = geo.frame(in: .global).minY
                                DispatchQueue.main.async {
                                    offset = minY
                                }
                                return AnyView(
                                    ZStack{
                                        Image("backgroundImage")
                                            .resizable()
                                            .offset(y: getOffset())
                                            .frame(height: getHeightTop())
                                            .ignoresSafeArea()
                                        BlurView()
                                            .offset(y: getOffset())
                                            .frame(height: getHeightTop())
                                            .opacity(blurViewOpacity())
                                    }
                                    
                                )
                            }
                            .frame(height: 180)
                        }
                        .background(.red)

                        HStack(spacing: 20){
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color(uiColor: .systemGray2))
                                .clipShape(Circle())
                            VStack(alignment: .leading,spacing: 8){
                                Text("신현호입니다아아아아")
                                    .font(Font.system(size: 18, weight: .bold))
                                    .foregroundColor(Color.white)
                                Text("답변완료 356개")
                                    .font(Font.system(size: 14, weight: .bold))
                                    .foregroundColor(Color.white)
                            }
//                            .offset(y: setTitleTextOffset() )
                            .opacity(getTitleOpacity())
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
                        .padding(.top,40)
                        .offset(y:getNavBarOffset())
                        
                    }
                    .zIndex(0)
                    
                    //상단에있는 것들 이외
                    VStack(alignment: .leading,spacing: 0){
                        
                        //프로필이미지 & 팔로우버튼
                        HStack(alignment: .center){
                            Image("profileImage")
                                .resizable()
                                .frame(width: 100,height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(.white,lineWidth: 3))
                                .offset(x: 30, y: -40)
                            Spacer()
                            Button {
                                print("follow!!")
                            } label: {
                                Image(systemName: "plus")
                                Text("팔로우")
                            }
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .padding(.vertical,8)
                            .padding(.horizontal,16)
                            .foregroundColor(.red)
                            .background(Capsule().strokeBorder(.red,lineWidth: 2))
                        }
                        
                        //디테일유저정보
                        VStack (alignment: .leading,spacing: 10){
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
                                //                    .lineLimit(nil)
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
                                    Text("100%")
                                        .fontWeight(.bold)
                                    Text("답변률")
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
                            .padding(.horizontal)
                        }
                        .padding(.top,-15)
                        
                        //답변완료 새질문 거절질문
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
                        .padding(.vertical, 10)
                        
                            
                    }
                    .padding(.horizontal, 15)
                    .zIndex(offset > -20 ? 1 : -1)
                    
                }
                
                
            }
            .ignoresSafeArea()
//            .background(.orange)
        }
        
    }
    
    //MARK: - Methods
    func blurViewOpacity()->Double{
        
        let progress = -offset  / 10
//        print(progress)
        return Double( -offset > 80 ? progress : 0)
    }
    
    func setTitleTextOffset() -> CGFloat {
        let textOffset = offset + 100
        return textOffset
    }
    
}

struct GeoTest_Previews: PreviewProvider {
    static var previews: some View {
        GeoTest()
    }
}

struct BlurView: UIViewRepresentable {

    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}


extension GeoTest {
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
        .padding(.top,topSafeArea)
        
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
                //                    .lineLimit(nil)
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

