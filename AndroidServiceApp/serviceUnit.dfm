object DM: TDM
  OldCreateOrder = False
  OnStartCommand = AndroidServiceStartCommand
  Height = 467
  Width = 581
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'http://azomva.com/rest'
    Params = <>
    HandleRedirects = True
    Left = 88
    Top = 24
  end
  object RESTRequestCheckNotification: TRESTRequest
    Client = RESTClient1
    Params = <>
    Resource = 'notifications/get'
    Response = RESTResponseCheckNotification
    SynchronizedEvents = False
    Left = 88
    Top = 72
  end
  object RESTResponseCheckNotification: TRESTResponse
    ContentType = 'application/json'
    Left = 88
    Top = 120
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Active = True
    Dataset = FDMemTableNotifications
    FieldDefs = <>
    ResponseJSON = RESTResponseCheckNotification
    Left = 88
    Top = 176
  end
  object FDMemTableNotifications: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'notification_type_id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'title'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'description'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'fire_time'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'executed'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'action_id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'create_date'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'executed_date'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'notification_type_name'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 88
    Top = 224
    object FDMemTableNotificationsid: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object FDMemTableNotificationsnotification_type_id: TWideStringField
      FieldName = 'notification_type_id'
      Size = 255
    end
    object FDMemTableNotificationstitle: TWideStringField
      FieldName = 'title'
      Size = 255
    end
    object FDMemTableNotificationsdescription: TWideStringField
      FieldName = 'description'
      Size = 255
    end
    object FDMemTableNotificationsfire_time: TWideStringField
      FieldName = 'fire_time'
      Size = 255
    end
    object FDMemTableNotificationsexecuted: TWideStringField
      FieldName = 'executed'
      Size = 255
    end
    object FDMemTableNotificationsaction_id: TWideStringField
      FieldName = 'action_id'
      Size = 255
    end
    object FDMemTableNotificationscreate_date: TWideStringField
      FieldName = 'create_date'
      Size = 255
    end
    object FDMemTableNotificationsexecuted_date: TWideStringField
      FieldName = 'executed_date'
      Size = 255
    end
    object FDMemTableNotificationsnotification_type_name: TWideStringField
      FieldName = 'notification_type_name'
      Size = 255
    end
  end
  object NotificationCenter1: TNotificationCenter
    Left = 232
    Top = 40
  end
  object Timer1: TTimer
    Enabled = False
    Left = 232
    Top = 96
  end
end
