import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image("western")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180)
                    .padding(.vertical, 0)
                    .shadow(radius: 5)

                Text("GPA Calculator")
                    .bold()
                    .font(.system(size: 28))
                    .font(.headline)

                TableRow()
            }
            .padding()
            .background(Color(red: 242/256, green: 232/256, blue: 256/256))
        }
    }
}

struct TableRow: View {
    @State private var userInput1: [String]   = [""]
    @State private var userInput2: [String]   = [""]
    @State private var selectionArr: [Double] = [0.5]

    private let creditOptions = [0.5, 1.0]
    
    private var gpaAverage: Double {
        var gradeSum: Double = 0.0
        var creditSum: Double = 0.0
        for (index, gradeStr) in userInput2.enumerated() {
            if let grade = Double(gradeStr) {
                let currCredit = selectionArr[index]
                gradeSum += gpaFromGrade(grade) * currCredit
                creditSum += currCredit        // add credit here too
            }
        }

        // avoid division by zero
        guard creditSum > 0 else { return 0 }
        return gradeSum / creditSum
    }
    
    func gpaFromGrade(_ grade: Double) -> Double {
        if grade >= 90.0 {
            return 4.0
        } else if grade >= 85.0 {
            return 3.9
        } else if grade >= 80.0 {
            return 3.7
        } else if grade >= 77.0 {
            return 3.3
        } else if grade >= 73.0 {
            return 3.0
        } else if grade >= 70.0 {
            return 2.7
        } else if grade >= 67.0 {
            return 2.3
        } else if grade >= 63.0 {
            return 2.0
        } else if grade >= 60.0 {
            return 1.7
        } else if grade >= 57.0 {
            return 1.3
        } else if grade >= 53.0 {
            return 1.0
        } else if grade >= 50.0 {
            return 0.7
        } else {
            return 0.0
        }
    }


    // Valid if empty OR parses to a Double in 0…100
    private func isValidGrade(_ text: String) -> Bool {
        if text.isEmpty { return true }
        if let value = Double(text), (0.0...100.0).contains(value) {
            return true
        }
        return false
    }

    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                // Card background
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: 350, height: 400)

                // Column headers
                Text("Course Name").bold().offset(x: -90, y: 20)
                Text("Grade (%)").bold().offset(x: 30, y: 20)
                Text("Credit").bold().offset(x: 115, y: 20)

                // Inputs
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(userInput1.indices, id: \.self) { i in
                            HStack(spacing: 8) {
                                // Course name
                                TextField("Course", text: $userInput1[i])
                                    .frame(width: 100)
                                    .padding(6)
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray))
                                    .foregroundColor(.gray)

                                // Grade with live validation
                                TextField("Grade", text: $userInput2[i])
                                    .frame(width: 60)
                                    .padding(6)
                                    .keyboardType(.decimalPad)
                                    .foregroundColor(.gray)
                                    .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(isValidGrade(userInput2[i]) ? Color.gray : Color.red))

                                // Credit picker
                                Picker("", selection: $selectionArr[i]) {
                                    ForEach(creditOptions, id: \.self) { opt in
                                        Text(String(format: "%.1f", opt))
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .tint(.gray)
                                .frame(width: 65)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray))
                            }
                        }
                    }
                    .padding(.top, 55)
                    .padding(.horizontal)
                }
                .frame(width: 330, height: 300)
                .clipped()
                .padding(.bottom, 40)

                // Add Course button
                Button(action: {
                    userInput1.append("")
                    userInput2.append("")
                    selectionArr.append(creditOptions.first!)
                }) {
                    HStack {
                        Text("Add Course")
                            .font(.headline)
                            .underline()
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 16))
                    }
                }
                .foregroundColor(Color(red: 75/255, green: 0, blue: 130/255))
                .offset(y: 360)
            }
            .shadow(radius: 5)
            // “Find GPA” as a NavigationLink
            NavigationLink {
                let finalGpa: Double = gpaAverage
                GPAResultView(gpa: finalGpa)
            } label: {
                HStack {
                    Text("Find GPA")
                        .font(.headline)
                    Image(systemName: "arrow.right")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 20)
                .background(Color(red: 75/255, green: 0, blue: 130/255))
                .cornerRadius(8)
                .padding(.top, 20)
                .shadow(radius: 8)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal)
    }
}

struct GPAResultView: View {
    
    let gpa: Double
    var body: some View {
        Text(String(format:"%.2f",gpa))
            .font(.largeTitle)
            .navigationTitle("Result")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

