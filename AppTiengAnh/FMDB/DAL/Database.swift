    //
    //  Database.swift
    //  AppTiengAnh
    //
    //  Created by Nguyen Thi Tham on 21/5/24.
    //

    // Database.swift
    import Foundation
    import UIKit
    import os.log

    class Database {
        
        
        private let DB_NAME = "vocabulary.sqlite"
        private let DB_PATH: String?
        private let database: FMDatabase?
        
        private let VOCABULARY_TABLE_NAME = "vocabulary"
        private let VOCABULARY_ID = "_id"
        private let VOCABULARY_IMAGE = "image"
        private let VOCABULARY_WORD = "word"
        private let VOCABULARY_PART_OF_SPEECH = "part_of_speech"
        private let VOCABULARY_PHONETIC = "phonetic"
        private let VOCABULARY_MEANING = "meaning"
        private let VOCABULARY_AUDIO_FILE = "audio_file"
        
        init() {
            let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            DB_PATH = directories[0] + "/" + DB_NAME
            database = FMDatabase(path: DB_PATH)
            if database != nil {
                os_log("Database created successfully")
                let sql = """
                CREATE TABLE IF NOT EXISTS \(VOCABULARY_TABLE_NAME) (
                    \(VOCABULARY_ID) INTEGER PRIMARY KEY AUTOINCREMENT,
                    \(VOCABULARY_IMAGE) TEXT,
                    \(VOCABULARY_WORD) TEXT,
                    \(VOCABULARY_PART_OF_SPEECH) TEXT,
                    \(VOCABULARY_PHONETIC) TEXT,
                    \(VOCABULARY_MEANING) TEXT,
                    \(VOCABULARY_AUDIO_FILE) TEXT,
                    unit INTEGER
                )
                """
                if open() {
                    if !database!.tableExists(VOCABULARY_TABLE_NAME) {
                        let _ = createTable(sql: sql)
                    }
                    close()
                }
            } else {
                os_log("Database initialization failed")
            }
        }

        
        private func open()->Bool {
            var success = false
            if let database = database {
                if database.open() {
                    os_log("Mở CSDL thành công")
                    success = true
                } else {
                    os_log("Không mở được CSDL")
                }
            }
            return success
        }
        
        private func close() {
            if let database = database {
                database.close()
                os_log("Đóng CSDL thành công")
            }
        }
        
        private func createTable(sql: String)->Bool {
            var success = false
            if let database = database {
                if database.executeStatements(sql) {
                    os_log("Tạo bảng thành công")
                    success = true
                } else {
                    os_log("Tạo bảng không thành công: %@", log: OSLog.default, type: .error, database.lastErrorMessage())
                }
            }
            return success
        }
        
        func insert(vocabulary: Vocabulary, unit: Int) -> Bool {
            var success = false
            if open() {
                if let database = database, database.tableExists(VOCABULARY_TABLE_NAME) {
                    let sql = "INSERT INTO \(VOCABULARY_TABLE_NAME) (\(VOCABULARY_IMAGE), \(VOCABULARY_WORD), \(VOCABULARY_PART_OF_SPEECH), \(VOCABULARY_PHONETIC), \(VOCABULARY_MEANING), \(VOCABULARY_AUDIO_FILE), unit) VALUES (?, ?, ?, ?, ?, ?, ?)"
                    
                    var strImage = ""
                    if let imageData = vocabulary.image?.pngData() {
                        strImage = imageData.base64EncodedString(options: .lineLength64Characters)
                    }
                    
                    if database.executeUpdate(sql, withArgumentsIn: [strImage, vocabulary.word, vocabulary.partOfSpeech, vocabulary.phonetic, vocabulary.meaning, vocabulary.audioFile, unit]) {
                        os_log("Thêm từ vựng thành công")
                        success = true
                    } else {
                        os_log("Thêm từ vựng không thành công: %@", log: OSLog.default, type: .error, database.lastErrorMessage())
                    }
                }
                close()
            }
            return success
        }

        func loadVocabulary(unit: Int) -> [Vocabulary] {
            var vocabularies = [Vocabulary]()
            if open() {
                let query = "SELECT * FROM \(VOCABULARY_TABLE_NAME) WHERE unit = ?"
                if let resultSet = database?.executeQuery(query, withArgumentsIn: [unit]) {
                    while resultSet.next() {
                        let imageString = resultSet.string(forColumn: VOCABULARY_IMAGE)
                        let imageData = Data(base64Encoded: imageString ?? "")
                        let image = imageData != nil ? UIImage(data: imageData!) : nil
                        let word = resultSet.string(forColumn: VOCABULARY_WORD) ?? ""
                        let partOfSpeech = resultSet.string(forColumn: VOCABULARY_PART_OF_SPEECH) ?? ""
                        let phonetic = resultSet.string(forColumn: VOCABULARY_PHONETIC) ?? ""
                        let meaning = resultSet.string(forColumn: VOCABULARY_MEANING) ?? ""
                        let audioFile = resultSet.string(forColumn: VOCABULARY_AUDIO_FILE) ?? ""
                        let vocabulary = Vocabulary(image: image, word: word, partOfSpeech: partOfSpeech, phonetic: phonetic, meaning: meaning, audioFile: audioFile)
                        vocabularies.append(vocabulary)
                    }
                } else {
                    os_log("Query execution failed: %@", log: OSLog.default, type: .error, database?.lastErrorMessage() ?? "")
                }
                close()
            } else {
                os_log("Failed to open database", log: OSLog.default, type: .error)
            }
            return vocabularies
        }

        func addUnitsData() {
                // Unit 1
                let unit1Vocabularies = [
                    Vocabulary(image: nil, word: "activity", partOfSpeech: "n", phonetic: "/ækˈtɪv.ə.ti/", meaning: "hoạt động", audioFile: nil),
                    Vocabulary(image: nil, word: "art", partOfSpeech: "n", phonetic: "/ɑːt/", meaning: "nghệ thuật", audioFile: nil),
                    Vocabulary(image: nil, word: "boarding school", partOfSpeech: "n", phonetic: "/ˈbɔː.dɪŋ ˌskuːl/", meaning: "trường nội trú", audioFile: nil)
                ]

                for vocabulary in unit1Vocabularies {
                    let _ = insert(vocabulary: vocabulary, unit: 1)
                }

                // Unit 2
                let unit2Vocabularies = [
                    Vocabulary(image: nil, word: "between", partOfSpeech: "prep", phonetic: "/bɪˈtwiːn/", meaning: "ở giữa", audioFile: nil),
                    Vocabulary(image: nil, word: "chest of drawers", partOfSpeech: "n", phonetic: "/ˌtʃest əv ˈdrɔːz/", meaning: "tủ có ngăn kéo", audioFile: nil),
                    Vocabulary(image: nil, word: "cooker", partOfSpeech: "n", phonetic: "/ˈkʊk.ər/", meaning: "bếp", audioFile: nil)
                ]

                for vocabulary in unit2Vocabularies {
                    let _ = insert(vocabulary: vocabulary, unit: 2)
                }

                // Unit 3
                let unit3Vocabularies = [
                    Vocabulary(image: nil, word: "active", partOfSpeech: "adj", phonetic: "/ˈæk.tɪv/", meaning: "hăng hái, năng động", audioFile: nil),
                    Vocabulary(image: nil, word: "appearance", partOfSpeech: "n", phonetic: "/əˈpɪə.rəns/", meaning: "bề ngoài, ngoại hình", audioFile: nil),
                    Vocabulary(image: nil, word: "careful", partOfSpeech: "adj", phonetic: "/ˈkeə.fəl/", meaning: "cẩn thận", audioFile: nil)
                ]

                for vocabulary in unit3Vocabularies {
                    let _ = insert(vocabulary: vocabulary, unit: 3)
                }
            }
        
    }
        
