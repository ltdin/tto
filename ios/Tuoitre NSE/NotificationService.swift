//
//  NotificationService.swift
//  Tuoitre NSE
//
//  Created by Rivercrane Vietnam on 02/08/2022.
//  Copyright © 2022 The Chromium Authors. All rights reserved.
//
import UserNotifications
import SmartPush

class NotificationService: UNNotificationServiceExtension {
  
  let smartechServiceExtension = SMTNotificationServiceExtension()
  
  override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
    //...
    if SmartPush.sharedInstance().isNotification(fromSmartech:request.content.userInfo) {
     smartechServiceExtension.didReceive(request, withContentHandler: contentHandler)
 }
    //...
  }
  
  override func serviceExtensionTimeWillExpire() {
    //...
    smartechServiceExtension.serviceExtensionTimeWillExpire()
    //...
  }
}
