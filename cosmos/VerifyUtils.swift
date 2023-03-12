//
//  TestSwift.swift
//  cosmos
//
//  Created by wshaolin on 2023/3/3.
//

import Foundation
import Alamofire
import HandyJSON
import HandyHTTP
import CommonUI

@objcMembers class VerifyUtils : NSObject {
    public static func verify(mobile: String?,
                              authCode: String?,
                              closure: @escaping(String) -> Void) {
        let request = VerifyRequest()
        request.addParam(name: "mobile", value: mobile)
        request.addParam(name: "auth_code", value: authCode)
        request.response(success: {(data: [String: Any]) in
            if let model = VerifyModel.deserialize(from: data) {
                closure(model.isValid() ? "接口请求成功" : model.msg!)
            }else{
                closure("解析数据失败")
            }
        }, failure: closure)
    }
}

class VerifyRequest : BaseURLRequest {
    override func baseURL() -> String {
        return "http://47.108.237.77"
    }
    
    override func path() -> String {
        return "/assist/xx/user/verify"
    }
    
    override func method() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    override func encoding() -> ParameterEncoding {
        return URLEncoding.default
    }
    
    override func deserialize(from: [String : Any]) -> BaseModel? {
        return VerifyModel.deserialize(from: from)
    }
}

class VerifyModel : BaseModel {
    var data: VerifyDataModel?
}

class VerifyDataModel : JSONModel {
    var id: Int64? = 0
    var mobile: String? = ""
    var authCode: String? = ""
    var deviceId: String? = ""
    var name: String? = ""
    var sex: Int? = 0
    var enabled: Bool = false
    var appAuthEnabled: Bool = false
    var radioEnabled: Bool = false
    var trialDate: Int64? = 0
    var lastDate: Int64? = 0
    var note: String? = ""
}
