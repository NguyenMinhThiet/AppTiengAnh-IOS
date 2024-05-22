//
//  Vocabulary.swift
//  AppTiengAnh
//
//  Created by Nguyen Thi Tham on 21/5/24.
//

import UIKit

class Vocabulary {
    var image: UIImage?
    var word: String
    var partOfSpeech: String
    var phonetic: String
    var meaning: String
    var audioFile: String?

    init(image: UIImage?, word: String, partOfSpeech: String, phonetic: String, meaning: String, audioFile: String?) {
        self.image = image
        self.word = word
        self.partOfSpeech = partOfSpeech
        self.phonetic = phonetic
        self.meaning = meaning
        self.audioFile = audioFile
    }
}

