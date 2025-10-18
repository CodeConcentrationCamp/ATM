//
//  CityModel.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/10/17.
//

import UIKit
import HandyJSON

// 根模型
struct CityModel: HandyJSON {
    // 存储 StandingMModel 数组（对应原 OC 的 standing 属性）
    var standing: [StandingMModel] = []
    

}

// 省级/第一层级模型
struct StandingMModel: HandyJSON {
    var subsided: String?
    var standing: [AModel] = []
    
}

// 市级/第二层级模型
struct AModel: HandyJSON {
    var subsided: String?
    var standing: [BModel] = []
    
}

// 区级/第三层级模型
struct BModel: HandyJSON {
    var subsided: String?
}


// 扩展 CityModel 实现工具方法
extension CityModel {
    // 1. 模型容器属性的泛型映射（对应原 modelContainerPropertyGenericClass）
    // HandyJSON 通过类名自动映射，无需额外配置，若有特殊映射可在 init 中处理
    
    // 2. 根据 dfRow 和 cityRow 获取 BModel 数组
    static func getSf(dfRow: Int, cityRow: Int) -> [BModel] {
        let qyArr = NSMutableArray()
        // 获取对应行的 AModel
        let mm = getCityPass(row: dfRow)[cityRow]
        // 遍历 AModel 的 standing 数组，添加到结果
        for bb in mm.standing {
            qyArr.add(bb)
        }
        return qyArr as! [BModel]
    }
    
    // 3. 根据 row 获取 AModel 数组
    static func getCityPass(row: Int) -> [AModel] {
        guard let cityModel = getAdressSettingModel() else { return [] }
        let cityArr = NSMutableArray()
        // 获取对应行的 StandingMModel
        let a = cityModel.standing[row]
        // 遍历 StandingMModel 的 standing 数组，添加到结果
        for vv in a.standing {
            cityArr.add(vv)
        }
        return cityArr as! [AModel]
    }
    
    // 4. 获取所有 StandingMModel 数组
    static func getSFArray() -> [StandingMModel] {
        guard let cityModel = getAdressSettingModel() else { return [] }
        let arr = NSMutableArray()
        for sftitle in cityModel.standing {
            arr.add(sftitle)
        }
        return arr as! [StandingMModel]
    }
    
    // 5. 网络请求获取地址数据
    
    
    
    static func getAddSuccess(success: @escaping (_ mm:CityModel) -> Void) {
        NetworkManager.shared.request(API.getAdress, modelType: CityModel.self) { mm, responseModel in
            clearAdressSettingModel()
            // 解析模型并保存
            var cityModel = CityModel()
            cityModel = mm
            cityModel.saveAdressSettingModel()
            success(cityModel)
        } failure:{ error,responseModel in}
    }
    
    // 6. 本地存储路径
    static func userSavePath() -> String {
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (docPath as NSString).appendingPathComponent("ATM_AdressModel")
    }
    
    // 7. 从本地读取模型
    static func getAdressSettingModel() -> CityModel? {
        let filePath = userSavePath()
        let fileManager = FileManager.default
        
        // 检查文件是否存在
        guard fileManager.fileExists(atPath: filePath) else { return nil }
        
        // 读取文件内容
        do {
            let jsonString = try String(contentsOfFile: filePath, encoding: .utf8)
            return CityModel.deserialize(from: jsonString)
        } catch {
            return nil
        }
    }
    
    // 8. 保存模型到本地
    func saveAdressSettingModel() {
        let filePath = CityModel.userSavePath()
        let fileManager = FileManager.default
        
        // 若文件不存在则创建
        if !fileManager.fileExists(atPath: filePath) {
            fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
        }
        
        // 序列化为 JSON 并写入
        if let jsonString = self.toJSONString() {
            try? jsonString.write(toFile: filePath, atomically: true, encoding: .utf8)
        }
    }
    
    // 9. 清除本地存储的模型
    static func clearAdressSettingModel() {
        let filePath = userSavePath()
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            try? fileManager.removeItem(atPath: filePath)
        }
    }
}
