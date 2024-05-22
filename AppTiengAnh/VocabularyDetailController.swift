//
//  ViewController.swift
//  AppTiengAnh
//
//  Created by Nguyen Thi Tham on 16/5/24.
//

import UIKit
import AVFoundation

class VocabularyDetailController: UIViewController {
    
    var selectedUnit: String?
    @IBOutlet weak var flashcardView: UIView!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var phoneticLabel: UILabel!
    @IBOutlet weak var partOfSpeechLabel: UILabel!
    @IBOutlet weak var playAudioButton: UIButton!
    
    var isShowingFront = true
    var vocabularyList: [Vocabulary] = []
    var currentIndex: Int = 0
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadVocabularyData()
        updateFlashcard()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(flipFlashcard))
        flashcardView.addGestureRecognizer(tapGestureRecognizer)
    }

    func loadVocabularyData() {
        guard let unit = selectedUnit else {
            print("No unit selected")
            return
        }
        let db = Database()
        switch unit {
        case "Unit1":
            vocabularyList = db.loadVocabulary(unit: 1)
        case "Unit2":
            vocabularyList = db.loadVocabulary(unit: 2)
        case "Unit3":
            vocabularyList = db.loadVocabulary(unit: 3)
        default:
            vocabularyList = []
        }
        
        print("Loaded vocabulary for unit \(unit): \(vocabularyList)")
    }

    func updateFlashcard() {
        guard !vocabularyList.isEmpty, currentIndex >= 0, currentIndex < vocabularyList.count else {
            // Hiển thị thông báo hoặc xử lý trường hợp không có từ vựng hợp lệ
            frontLabel.text = "No vocabulary available"
            backLabel.text = ""
            imageView.image = nil
            phoneticLabel.text = ""
            partOfSpeechLabel.text = ""
            return
        }
        
        let currentVocabulary = vocabularyList[currentIndex]
        frontLabel.text = currentVocabulary.word
        backLabel.text = currentVocabulary.meaning
        imageView.image = currentVocabulary.image
        phoneticLabel.text = currentVocabulary.phonetic
        partOfSpeechLabel.text = currentVocabulary.partOfSpeech
    }


    @objc func flipFlashcard() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: flashcardView, duration: 0.3, options: transitionOptions, animations: {
            if self.isShowingFront {
                self.frontLabel.isHidden = true
                self.backLabel.isHidden = false
            } else {
                self.frontLabel.isHidden = false
                self.backLabel.isHidden = true
            }
        }, completion: nil)
        
        isShowingFront = !isShowingFront
    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func previousVocabulary(_ sender: UIButton) {
        if currentIndex > 0 {
            currentIndex -= 1
            updateFlashcard()
        } else {
            // Hiển thị thông báo hoặc xử lý khi không thể di chuyển về trước
            print("No previous vocabulary")
        }
    }

    @IBAction func nextVocabulary(_ sender: UIButton) {
        if currentIndex < vocabularyList.count - 1 {
            currentIndex += 1
            updateFlashcard()
        } else {
            // Hiển thị thông báo hoặc xử lý khi không thể di chuyển về sau
            print("No more vocabulary")
        }
    }


    @IBAction func playAudio(_ sender: UIButton) {
        let currentVocabulary = vocabularyList[currentIndex]
        if let audioPath = Bundle.main.path(forResource: currentVocabulary.audioFile, ofType: nil) {
            let url = URL(fileURLWithPath: audioPath)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Could not load audio file: \(error)")
            }
        }
    }
}
