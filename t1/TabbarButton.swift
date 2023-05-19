
import SwiftUI

struct TabbarButton: View {
    
    @Binding var current : String
    
    var image : String
    var animation : Namespace.ID
    
    var body: some View {
        Button {
            withAnimation {
                current = image
            }
        } label: {
            VStack{
                Image(systemName: image)
                    .font(.title2)
                    .foregroundColor(current == image ? .blue : .black.opacity(0.3))
                    .frame(height: 35)
                
                ZStack{
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 4)
                    
                    //geometry effect slide animation
                    if current == image {
                        Rectangle()
                            .fill(.red)
                            .frame(height: 4)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                    
                }
            }
        }

    }
}
