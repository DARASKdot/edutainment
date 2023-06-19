
import SwiftUI

struct ContentView: View {
    
    @State private var multiplicand: Int = 1
    @State private var multiplier: Int = 1
    
    @State private var showRandomQuestions = false
    @State private var randomSegmentIndex = 0
    @State private var questionCount = 0
    @State private var correctCount = 0
    
    let questionCounts = [3, 5, 10]
    
    @State private var currentQuestionIndex = 0
    @State private var currentQuestion: (Int, Int)? = nil
    @State private var userAnswer = ""
    @State private var isShowingResult = false
    @State private var isAnswerCorrect = false
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ScrollView(.horizontal) {
                    MultipliTable()
                }
                .padding(.top, 10)
                .padding(.trailing, 10)
            }
            .padding(.top, 10)
            .padding(.leading, 10)
            
            Stepper(value: $multiplicand, in: 1...12, label: {
                Text("Multiplicand: \(multiplicand)")
            })
            .padding()
            
            Stepper(value: $multiplier, in: 1...12, label: {
                Text("Multiplier: \(multiplier)")
            })
            .padding()
            
            Text("Result: \(multiplicand) x \(multiplier) = \(multiplicand * multiplier)")
                .font(.headline)
                .padding(.bottom)
            
            Picker(selection: $randomSegmentIndex, label: Text("Question Type")) {
                Text("Random from Table").tag(0)
                Text("Complete Random").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            Picker(selection: $questionCount, label: Text("Question Count")) {
                ForEach(questionCounts, id: \.self) { count in
                    Text("\(count)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            Text("Correct Answers: \(correctCount) / \(questionCount)")
                .font(.headline)
                .padding(.bottom)
            
            Button(action: startQuestions) {
                Text("Start Questions")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            if isShowingResult {
                Text(isAnswerCorrect ? "Correct!" : "Incorrect!")
                    .font(.headline)
                    .foregroundColor(isAnswerCorrect ? .green : .red)
                    .padding()
            }
            
            if let (multiplicand, multiplier) = currentQuestion {
                Text("Question: \(multiplicand) x \(multiplier) = ?")
                    .font(.headline)
                    .padding()
                
                TextField("Enter your answer", text: $userAnswer, onCommit: checkAnswer)
                    .keyboardType(.numberPad) // 数字のみのキーボードを表示する
                    .padding()
            }
        }
    }
    
    private func startQuestions() {
        correctCount = 0
        currentQuestionIndex = 0
        isShowingResult = false
        isAnswerCorrect = false
        
        if randomSegmentIndex == 0 {
            let randomNumbers = Array(Array(1...12).shuffled().prefix(questionCount))
            askQuestions(numbers: randomNumbers)
        } else {
            let randomNumbers = Array(Array(1...12).shuffled().prefix(questionCount))
            let randomMultipliers = Array(Array(1...12).shuffled().prefix(questionCount))
            askQuestions(numbers: randomNumbers, multipliers: randomMultipliers)
        }
    }
        
    private func askQuestions(numbers: [Int], multipliers: [Int] = []) {
        if currentQuestionIndex < questionCount {
            let multiplicand = numbers[currentQuestionIndex]
            let multiplier = multipliers.isEmpty ? Int.random(in: 1...12) : multipliers[currentQuestionIndex]
            currentQuestion = (multiplicand, multiplier)
            currentQuestionIndex += 1
            userAnswer = ""
            isShowingResult = false
        }
    }
    
    private func checkAnswer() {
        guard let (multiplicand, multiplier) = currentQuestion,
              let answer = Int(userAnswer) else {
            return
        }
        
        let correctAnswer = multiplicand * multiplier
        isAnswerCorrect = answer == correctAnswer
        if isAnswerCorrect {
            correctCount += 1
        }
        
        isShowingResult = true
    }
}

#Preview {
    ContentView()
}
