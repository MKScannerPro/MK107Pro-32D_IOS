
typedef NS_ENUM(NSInteger, mk_cu_centralConnectStatus) {
    mk_cu_centralConnectStatusUnknow,                                           //未知状态
    mk_cu_centralConnectStatusConnecting,                                       //正在连接
    mk_cu_centralConnectStatusConnected,                                        //连接成功
    mk_cu_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_cu_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_cu_centralManagerStatus) {
    mk_cu_centralManagerStatusUnable,                           //不可用
    mk_cu_centralManagerStatusEnable,                           //可用状态
};

typedef NS_ENUM(NSInteger, mk_cu_wifiSecurity) {
    mk_cu_wifiSecurity_personal,
    mk_cu_wifiSecurity_enterprise,
};

typedef NS_ENUM(NSInteger, mk_cu_eapType) {
    mk_cu_eapType_peap_mschapv2,
    mk_cu_eapType_ttls_mschapv2,
    mk_cu_eapType_tls,
};


typedef NS_ENUM(NSInteger, mk_cu_connectMode) {
    mk_cu_connectMode_TCP,                                          //TCP
    mk_cu_connectMode_CASignedServerCertificate,                    //SSL.Do not verify the server certificate.
    mk_cu_connectMode_CACertificate,                                //SSL.Verify the server's certificate
    mk_cu_connectMode_SelfSignedCertificates,                       //SSL.Two-way authentication
};

//Quality of MQQT service
typedef NS_ENUM(NSInteger, mk_cu_mqttServerQosMode) {
    mk_cu_mqttQosLevelAtMostOnce,      //At most once. The message sender to find ways to send messages, but an accident and will not try again.
    mk_cu_mqttQosLevelAtLeastOnce,     //At least once.If the message receiver does not know or the message itself is lost, the message sender sends it again to ensure that the message receiver will receive at least one, and of course, duplicate the message.
    mk_cu_mqttQosLevelExactlyOnce,     //Exactly once.Ensuring this semantics will reduce concurrency or increase latency, but level 2 is most appropriate when losing or duplicating messages is unacceptable.
};

typedef NS_ENUM(NSInteger, mk_cu_filterRelationship) {
    mk_cu_filterRelationship_null,
    mk_cu_filterRelationship_mac,
    mk_cu_filterRelationship_advName,
    mk_cu_filterRelationship_rawData,
    mk_cu_filterRelationship_advNameAndRawData,
    mk_cu_filterRelationship_macAndadvNameAndRawData,
    mk_cu_filterRelationship_advNameOrRawData,
    mk_cu_filterRelationship_advNameAndMacData,
};


@protocol mk_cu_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param deviceModel device
- (void)mk_cu_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_cu_startScan;

/// Stops scanning equipment.
- (void)mk_cu_stopScan;

@end
