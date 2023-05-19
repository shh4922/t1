import SwiftUI

struct HomeView: View {
    
    @State var topSafeArea  = UIApplication.shared.windows.first?.safeAreaInsets.top
    
    @State var seleceFilter = HomeFilterEnum.newQuestion
    
    @Namespace var animation
    
    @State var isFilterShow = true
    
    @State var isBackgroundBlew = false
    @State var screenWidth = UIScreen.main.bounds.size.width
    
    
    
    private let imageHeight: CGFloat = 200 // 1
    private let collapsedImageHeight: CGFloat = 75 // 2
    
    //
    private func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY
    }
    
    
    //HeaderOffset Get
    private func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let sizeOffScreen = imageHeight - collapsedImageHeight // 3
//        print(offset)
        
        if offset < -sizeOffScreen {
            // Since we want 75 px fixed on the screen we get our offset of -225 or anything less than. Take the abs value of
            let imageOffset = abs(min(-sizeOffScreen, offset))
            
            // Now we can the amount of offset above our size off screen. So if we've scrolled -250px our size offscreen is -225px we offset our image by an additional 25 px to put it back at the amount needed to remain offscreen/amount on screen.
            return imageOffset - sizeOffScreen
        }
        
        
        // Image was pulled down
        if offset > 0 {
            return -offset
        }
//        
        
        return 0
    }
    
    
    private func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let imageHeight = geometry.size.height

        if offset > 0 {
            return imageHeight + offset
        }

        return imageHeight
    }
    
    
    private func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {
        // 2
        let offset = geometry.frame(in: .global).maxY

        let height = geometry.size.height
        let blur = (height - max(offset, 0)) / height // 3 (values will range from 0 - 1)
        return blur * 6 // Values will range from 0 - 6
    }
    private func getBlurRadiusForProfileImage(_ geometry: GeometryProxy) -> CGFloat {
        // 2
        let offset = geometry.frame(in: .global).maxY

        let height = geometry.size.height
        let blur = (height - max(offset, 0)) / height // 3 (values will range from 0 - 1)
        return blur * 100 // Values will range from 0 - 6
    }
    private func getBlurRadiusForVstack(_ geometry: GeometryProxy) -> CGFloat {
        
        let offset = geometry.frame(in: .global).maxY - 30
        print(offset)
        let height = geometry.size.height
        let blur = (height - max(offset, 0)) / height // 3 (values will range from 0 - 1)
        return blur * 10 // Values will range from 0 - 6
    }
    
    
    var body: some View {
        ZStack(alignment: .top){
            ScrollView(.vertical,showsIndicators: false){
                //프로필배경 & 프로필이미지
                GeometryReader { geo in
                    ZStack(alignment: .bottomLeading){
                        Image("backgroundImage")
                            .resizable()
                            .frame(height: self.getHeightForHeaderImage(geo))
                            .blur(radius: getBlurRadiusForImage(geo))
                            .ignoresSafeArea()
                            
                        Image("profileImage")
                            .resizable()
                            .frame(width: 100,height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.white,lineWidth: 3))
                            .offset(x:40,y: 50)
                            .blur(radius: getBlurRadiusForProfileImage(geo))
                    }
                    .offset(x: 0, y: self.getOffsetForHeaderImage(geo)) // 3
                    
                }
                .background(.orange)
                .frame(width: UIScreen.main.bounds.width, height: 200)
                
                GeometryReader{ geo  in
                    VStack{
                        followButton
                            .blur(radius: getBlurRadiusForVstack(geo))
                        userDetail
                            .blur(radius: getBlurRadiusForVstack(geo))
                        dummyText
//                        Spacer()
                    }
                    .frame(height: max(geo.size.height, geo.size.width))
                    .background(.green)
                }
                .background(.red)
                Spacer()
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
    
    var dummyText : some View {
        Text("Lorem ipsum dolor sit amet consectetur adipiscing elit donec, gravida commodo hac non mattis augue duis vitae inceptos, laoreet taciti at vehicula cum arcu dictum. Cras netus vivamus sociis pulvinar est erat, quisque imperdiet velit a justo maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis.sdfsdfsdfdsfsdfsdafjusto maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis.sdfsdfsdfdsfsdfsdafjusto maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis.sdfsdfsdfdsfsdfsdafjusto maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis.sdfsdfsdfdsfsdfsdafjusto maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis.sdfsdfsdfdsfsdfsdafjusto maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis.sdfsdfsdfdsfsdfsdafjusto maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis.sdfsdfsdfdsfsdfsdafjusto maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis.sdfsdfsdfdsfsdfsdafjusto maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis.sdfsdfsdfdsfsdfsdafjusto maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis.sdfsdfsdfdsfsdfsdaf")

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
