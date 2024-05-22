import UIKit

class ExerciseDetailController: UIViewController {
    
    var exerciseUnit: String?
    var currentQuestionIndex = 0
    var correctAnswers = 0
    let totalQuestions = 5 // Số lượng câu hỏi
    var questions: [Question] = [] // Mảng chứa các câu hỏi
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButtonA: UIButton!
    @IBOutlet weak var answerButtonB: UIButton!
    @IBOutlet weak var answerButtonC: UIButton!
    @IBOutlet weak var answerButtonD: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load các câu hỏi
        loadQuestions()
        // Hiển thị câu hỏi đầu tiên
        displayQuestion()
    }
    
    // Hàm load các câu hỏi (trong thực tế, bạn sẽ thay thế hàm này bằng việc lấy câu hỏi từ một nguồn dữ liệu như database hoặc file)
    func loadQuestions() {
        // Giả sử các câu hỏi được lưu trong một mảng questions
        // Đây chỉ là ví dụ, bạn cần thay thế với dữ liệu thực tế
        questions = [
            Question(text: "Question 1", answers: ["A", "B", "C", "D"], correctAnswerIndex: 0),
            Question(text: "Question 2", answers: ["A", "B", "C", "D"], correctAnswerIndex: 1),
            Question(text: "Question 3", answers: ["A", "B", "C", "D"], correctAnswerIndex: 2),
            Question(text: "Question 4", answers: ["A", "B", "C", "D"], correctAnswerIndex: 3),
            Question(text: "Question 5", answers: ["A", "B", "C", "D"], correctAnswerIndex: 0)
        ]
    }
    
    // Hàm hiển thị câu hỏi
    func displayQuestion() {
        let question = questions[currentQuestionIndex]
        questionLabel.text = question.text
        answerButtonA.setTitle(question.answers[0], for: .normal)
        answerButtonB.setTitle(question.answers[1], for: .normal)
        answerButtonC.setTitle(question.answers[2], for: .normal)
        answerButtonD.setTitle(question.answers[3], for: .normal)
        scoreLabel.text = "Score: \(correctAnswers)/\(currentQuestionIndex)"
    }
    
    // Hàm kiểm tra câu trả lời
    func checkAnswer(selectedAnswerIndex: Int) {
        let question = questions[currentQuestionIndex]
        let selectedButton: UIButton
        
        // Xác định button đã được chọn dựa trên selectedAnswerIndex
        switch selectedAnswerIndex {
        case 0:
            selectedButton = answerButtonA
        case 1:
            selectedButton = answerButtonB
        case 2:
            selectedButton = answerButtonC
        case 3:
            selectedButton = answerButtonD
        default:
            return
        }
        
        if selectedAnswerIndex == question.correctAnswerIndex {
            // Nếu trả lời đúng
            correctAnswers += 1
            selectedButton.backgroundColor = UIColor.green
            scoreLabel.textColor = UIColor.green
        } else {
            // Nếu trả lời sai
            selectedButton.backgroundColor = UIColor.red
            scoreLabel.textColor = UIColor.red
        }
        
        // Kiểm tra nếu đã hoàn thành tất cả câu hỏi
        if currentQuestionIndex == totalQuestions - 1 {
            // Hiển thị thông báo kết thúc và điểm số
            let alert = UIAlertController(title: "Kết thúc", message: "Bạn đã hoàn thành \(totalQuestions) câu hỏi. Điểm của bạn là \(correctAnswers)/\(totalQuestions). Bạn có muốn tiếp tục?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tiếp tục", style: .default, handler: { action in
                // Reset câu hỏi và điểm số nếu người dùng chọn tiếp tục
                self.currentQuestionIndex = 0
                self.correctAnswers = 0
                self.displayQuestion()
                self.resetButtonColors() // Đặt lại màu của các button
            }))
            alert.addAction(UIAlertAction(title: "Dừng lại", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            // Nếu chưa hoàn thành, tăng index để hiển thị câu hỏi tiếp theo
            currentQuestionIndex += 1
            // Hiển thị câu hỏi tiếp theo
            displayQuestion()
        }
    }
    
    // Hàm đặt lại màu của các button về màu mặc định
    func resetButtonColors() {
        answerButtonA.backgroundColor = nil
        answerButtonB.backgroundColor = nil
        answerButtonC.backgroundColor = nil
        answerButtonD.backgroundColor = nil
    }
    
    // Sự kiện khi người dùng chọn câu trả lời A
    @IBAction func answerButtonATapped(_ sender: UIButton) {
        checkAnswer(selectedAnswerIndex: 0)
    }
    
    // Sự kiện khi người dùng chọn câu trả lời B
    @IBAction func answerButtonBTapped(_ sender: UIButton) {
        checkAnswer(selectedAnswerIndex: 1)
    }
    
    // Sự kiện khi người dùng chọn câu trả lời C
    @IBAction func answerButtonCTapped(_ sender: UIButton) {
        checkAnswer(selectedAnswerIndex: 2)
    }
    
    // Sự kiện khi người dùng chọn câu trả lời D
    @IBAction func answerButtonDTapped(_ sender: UIButton) {
        checkAnswer(selectedAnswerIndex: 3)
    }
}

// Định nghĩa cấu trúc câu hỏi
struct Question {
    let text: String // Nội dung câu hỏi
    let answers: [String] // Các câu trả lời
    let correctAnswerIndex: Int // Index của câu trả lời đúng trong mảng answers
}
