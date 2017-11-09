object DM: TDM
  OldCreateOrder = False
  OnStartCommand = AndroidServiceStartCommand
  Height = 152
  Width = 265
  object NotificationCenter1: TNotificationCenter
    OnReceiveLocalNotification = NotificationCenter1ReceiveLocalNotification
    Left = 120
    Top = 48
  end
end
