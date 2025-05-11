import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("western")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:180)
                .padding(.vertical, 0)
                .shadow(radius:5)

            Text("GPA Calculator")
                .bold()
                .font(.system(size: 28))

            TableRow()
        }
        .padding()
    }
}

struct TableRow: View {
    // 1) Three parallel arrays to hold each row’s inputs
    @State private var userInput1: [String]   = [""]
    @State private var userInput2: [String]   = [""]
    @State private var selectionArr: [String] = ["0.5"]

    private let creditOptions = ["0.5", "1.0", "1.5", "2.0"]

    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                // Card background
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 240/256, green: 230/256, blue: 250/256))
                    .frame(width: 350, height: 400)

                // Column headers
                Text("Course Name")
                    .bold()
                    .offset(x: -90, y: 20)
                Text("Grade (%)")
                    .bold()
                    .offset(x: 30, y: 20)
                Text("Credit")
                    .bold()
                    .offset(x: 115, y: 20)

                // Scrollable list of input rows
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(userInput1.indices, id: \.self) { i in
                            HStack(spacing: 8) {
                                // Course name
                                TextField("Course", text: $userInput1[i])
                                    .frame(width: 100)
                                    .padding(6)
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black))
                                
                                // Grade
                                TextField("Grade", text: $userInput2[i])
                                    .frame(width: 60)
                                    .padding(6)
                                    .keyboardType(.decimalPad)
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black))
                                
                                
                                // Credit dropdown
                                Picker("Credit", selection: $selectionArr[i]) {
                                    ForEach(creditOptions, id: \.self) { opt in
                                        Text(opt)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .tint(.black)
                                .frame(width: 65)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black))
                            }
                        }
                    }
                }
                .frame(width: 330, height: 300)
                .clipped()
                .padding(.top, 55)
                .padding(.bottom, 40)
                .padding(.horizontal)
                
                // Button to add a new row
                Button(action: {
                    userInput1.append("")
                    userInput2.append("")
                    selectionArr.append(creditOptions.first ?? "")
                }){
                    Text("Add Course")
                        .underline()
                }
                
                .padding(.top, 0)
                .foregroundColor(
                    Color(red: 75/255, green: 0/255, blue: 130/255)
                )

                .offset(y:360)
              

            }
            .shadow(radius:5)
            
            Button(action: {
                // Your calculate-GPA logic here
            }) {
                HStack {
                    Text("Find GPA")
                        .font(.headline)
                    Image(systemName: "arrow.right")
                        .font(.headline)
                }
                .foregroundColor(.white)  // white text & icon
                .padding(.vertical, 12)
                .padding(.horizontal, 20)
                .background(
                    Color(red: 75/255, green: 0/255, blue: 130/255) // dark purple
                )
                .cornerRadius(8)
            }
    
            
        }
        .frame(maxHeight: .infinity, alignment: .top) // ← pin to top
          .padding(.horizontal)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

