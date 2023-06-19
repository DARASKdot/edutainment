
import SwiftUI

struct MultipliTable: View {
    let rows = 1...12
    let columns = 1...12
    
    var body: some View {
        VStack(spacing: 0) {
            // 列ヘッダー
            HStack(spacing: 0) {
                Text("×")
                    .frame(width: 40, height: 40)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.trailing, 2)
                
                ForEach(columns, id: \.self) { column in
                    Text("\(column)")
                        .frame(width: 40, height: 40)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 0) {
                    // 行ヘッダー
                    Text("\(row)")
                        .frame(width: 40, height: 40)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.trailing, 2)
                    
                    ForEach(columns, id: \.self) { column in
                        let result = row * column
                        let color = Color(red: Double(row) / 12, green: Double(column) / 12, blue: 0.7)
                        
                        Text("\(result)")
                            .frame(width: 40, height: 40)
                            .background(color)
                            .foregroundColor(.black)
                            .font(.headline)
                            .overlay(
                                Text("\(result)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .cornerRadius(4)
                                    .offset(x: -2,y: -2)
                            )
                    }
                }
            }
        }
    }
}

#Preview {
    MultipliTable()
}
