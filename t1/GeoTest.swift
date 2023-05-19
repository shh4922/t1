import SwiftUI

struct GeoTest: View {
    var body: some View {
        ZStack(alignment: .top){
            ScrollView(.vertical,showsIndicators: false){
                GeometryReader{ geo in
                    VStack{
                        Text("dkdkdkdkdkdkkdkddkdkdkdkdkdkkdkddkdkdkdkdkdkkdkddkdkdkdkdkdkkdkddkdkdkdkdkdkkdkddkdkdkdkdkdkkdkddkdkdkdkdkdkkdkddkdkdkdkdkdkkdkddkdkdkdkdkdkdkdkdkkdkd")
                            .lineLimit(nil)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(height: max(geo.size.height, geo.size.width)) 
                }
                
                
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct GeoTest_Previews: PreviewProvider {
    static var previews: some View {
        GeoTest()
    }
}
