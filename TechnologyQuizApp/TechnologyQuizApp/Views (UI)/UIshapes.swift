
extension Color {
    static let purpleGray = Color(red: 51 / 255, green: 47 / 255, blue: 88 / 255)
    static let lightPurpleGray = Color(red: 59 / 255, green: 55 / 255, blue: 105 / 255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
        // topLeading = top-left corner, bottomTrailing = bottom right corner -- creates diagonal gradient.
    }
}

import SwiftUI

struct ContentView1: View {
    var body: some View {
        ZStack {
            Color.purpleGray
                .ignoresSafeArea()

            Card(shape: "rectangle", width: 375, height: 250, cornerRadius: 30, padding: 10, color: .lightPurpleGray).position(x: 227, y: 425)
            
            HStack {
                Card(shape: "rectangle", width: 110, height: 150, cornerRadius: 30, padding: 0, color: .lightPurpleGray).position(x: 100, y: 700)
                Card(shape: "rectangle", width: 110, height: 150, cornerRadius: 30, padding: 0, color: .lightPurpleGray).position(x: 80, y: 700)
                Card(shape: "rectangle", width: 110, height: 150, cornerRadius: 30, padding: 0, color: .lightPurpleGray).position(x: 60, y: 700)
            }
            
            VStack {
                Card(shape: "rectangle", width: 355, height: 115, cornerRadius: 30, padding: 0, color: .blue).position(x: 250, y: 600)
                Card(shape: "rectangle", width: 355, height: 115, cornerRadius: 30, padding: 0, color: .blue).position(x: 250, y: 470)
                Card(shape: "rectangle", width: 450, height: 80, cornerRadius: 0, padding: 0, color: .lightPurpleGray).position(x: 215, y: 370)
            }
            
//            Card(shape: "circle", width: 200, height: 200, padding: 30, color: .orange).position(x: 290, y: 500)
//            Card(shape: "triangle", width: 100, height: 200, cornerRadius: 20, padding: 10, color: .red).position(x: 200, y: 400)
        }
    }
}

struct Card : View {
    var shape : String = ""
    var width : CGFloat = 0
    var height : CGFloat = 0
    var cornerRadius : CGFloat = 0
    var padding : CGFloat = 0
    var color : Color = .lightPurpleGray
    
    var body : some View {
        switch shape {
            case "rectangle":
                RoundedRectangle(cornerRadius: cornerRadius)
                    .size(CGSize(width: width, height: height))
                    .padding(padding)
                    .foregroundColor(color)
            case "circle":
                Circle()
                    .size(CGSize(width: width, height: height))
                    .padding(padding)
                    .foregroundColor(color)
            case "triangle":
                Triangle()
                    .frame(width: width, height: height)
                    .padding(padding)
                    .foregroundColor(color)
            default:
                RoundedRectangle(cornerRadius: 30)
                    .size(CGSize(width: 150, height: 150))
                    .padding(10)
                    .foregroundColor(color)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}
