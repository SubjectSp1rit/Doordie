//
//  AddFriendProtocols.swift
//  Doordie
//
//  Created by Arseniy on 04.04.2025.
//

protocol AddFriendBusinessLogic {
    func sendFriendRequest(_ request: AddFriendModels.SendFriendRequest.Request)
}

protocol AddFriendPresentationLogic {
    func presentFriendRequest(_ response: AddFriendModels.SendFriendRequest.Response)
}
