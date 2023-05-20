import SwiftUI

struct GeoTest: View {
    
    func getGeoProxy(_ proxy : GeometryProxy){
        print(proxy.frame(in: .global).minY)
    }
    var body: some View {
        
        GeometryReader { proxy1 in
            
            GeometryReader { proxy2 in
            
                GeometryReader { proxy3 in
//                    print(proxy3.frame(in: .global).minY)
                    
                }
                .frame(width: 200,height: 200)
                .background(.green)
                
                
            }
            .frame(width: 300,height: 300)
            .background(.orange)
            
            
            
        }
        .frame(width: 400,height: 400)
        .background(.red)
        
    }
}

struct GeoTest_Previews: PreviewProvider {
    static var previews: some View {
        GeoTest()
    }
}
