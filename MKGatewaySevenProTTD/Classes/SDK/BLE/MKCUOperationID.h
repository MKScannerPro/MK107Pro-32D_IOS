

typedef NS_ENUM(NSInteger, mk_cu_taskOperationID) {
    mk_cu_defaultTaskOperationID,
    
#pragma mark - Read
    mk_cu_taskReadDeviceModelOperation,        //读取产品型号
    mk_cu_taskReadFirmwareOperation,           //读取固件版本
    mk_cu_taskReadHardwareOperation,           //读取硬件类型
    mk_cu_taskReadSoftwareOperation,           //读取软件版本
    mk_cu_taskReadManufacturerOperation,       //读取厂商信息
    
#pragma mark - 自定义协议读取
    mk_cu_taskReadDeviceNameOperation,         //读取设备名称
    mk_cu_taskReadDeviceMacAddressOperation,    //读取MAC地址
    mk_cu_taskReadDeviceWifiSTAMacAddressOperation, //读取WIFI STA MAC地址
    mk_cu_taskReadNTPServerHostOperation,       //读取NTP服务器域名
    mk_cu_taskReadTimeZoneOperation,            //读取时区
    
#pragma mark - Wifi Params
    mk_cu_taskReadWIFISecurityOperation,        //读取设备当前wifi的加密模式
    mk_cu_taskReadWIFISSIDOperation,            //读取设备当前的wifi ssid
    mk_cu_taskReadWIFIPasswordOperation,        //读取设备当前的wifi密码
    mk_cu_taskReadWIFIEAPTypeOperation,         //读取设备当前的wifi EAP类型
    mk_cu_taskReadWIFIEAPUsernameOperation,     //读取设备当前的wifi EAP用户名
    mk_cu_taskReadWIFIEAPPasswordOperation,     //读取设备当前的wifi EAP密码
    mk_cu_taskReadWIFIEAPDomainIDOperation,     //读取设备当前的wifi EAP域名ID
    mk_cu_taskReadWIFIVerifyServerStatusOperation,  //读取是否校验服务器
    mk_cu_taskReadWIFIDHCPStatusOperation,              //读取Wifi DHCP开关
    mk_cu_taskReadWIFINetworkIpInfosOperation,          //读取Wifi IP信息
    
#pragma mark - MQTT Params
    mk_cu_taskReadServerHostOperation,          //读取MQTT服务器域名
    mk_cu_taskReadServerPortOperation,          //读取MQTT服务器端口
    mk_cu_taskReadClientIDOperation,            //读取Client ID
    mk_cu_taskReadServerUserNameOperation,      //读取服务器登录用户名
    mk_cu_taskReadServerPasswordOperation,      //读取服务器登录密码
    mk_cu_taskReadServerCleanSessionOperation,  //读取MQTT Clean Session
    mk_cu_taskReadServerKeepAliveOperation,     //读取MQTT KeepAlive
    mk_cu_taskReadServerQosOperation,           //读取MQTT Qos
    mk_cu_taskReadSubscibeTopicOperation,       //读取Subscribe topic
    mk_cu_taskReadPublishTopicOperation,        //读取Publish topic
    mk_cu_taskReadLWTStatusOperation,           //读取LWT开关状态
    mk_cu_taskReadLWTQosOperation,              //读取LWT Qos
    mk_cu_taskReadLWTRetainOperation,           //读取LWT Retain
    mk_cu_taskReadLWTTopicOperation,            //读取LWT topic
    mk_cu_taskReadLWTPayloadOperation,          //读取LWT Payload
    mk_cu_taskReadConnectModeOperation,         //读取MTQQ服务器通信加密方式
    
#pragma mark - Filter Params
    mk_cu_taskReadRssiFilterValueOperation,             //读取扫描RSSI过滤
    mk_cu_taskReadFilterRelationshipOperation,          //读取扫描过滤逻辑
    mk_cu_taskReadFilterMACAddressListOperation,        //读取MAC过滤列表
    mk_cu_taskReadFilterAdvNameListOperation,           //读取ADV Name过滤列表
    
#pragma mark - iBeacon Params
    mk_cu_taskReadAdvertiseBeaconStatusOperation,       //读取iBeacon开关
    mk_cu_taskReadBeaconMajorOperation,                 //读取iBeacon major
    mk_cu_taskReadBeaconMinorOperation,                 //读取iBeacon minor
    mk_cu_taskReadBeaconUUIDOperation,                  //读取iBeacon UUID
    mk_cu_taskReadBeaconAdvIntervalOperation,           //读取Adv interval
    mk_cu_taskReadBeaconTxPowerOperation,               //读取Tx Power
    mk_cu_taskReadBeaconRssiOperation,                      //读取RSSI@1m
    
#pragma mark - 计电量参数
    mk_cu_taskReadMeteringSwitchOperation,              //读取计量数据上报开关
    mk_cu_taskReadPowerReportIntervalOperation,         //读取电量数据上报间隔
    mk_cu_taskReadEnergyReportIntervalOperation,        //读取电能数据上报间隔
    mk_cu_taskReadLoadDetectionNotificationStatusOperation, //读取负载检测通知开关
    
    
#pragma mark - 密码特征
    mk_cu_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 配置
    mk_cu_taskEnterSTAModeOperation,                //设备重启进入STA模式
    mk_cu_taskConfigNTPServerHostOperation,         //配置NTP服务器域名
    mk_cu_taskConfigTimeZoneOperation,              //配置时区
    
#pragma mark - Wifi Params
    
    mk_cu_taskConfigWIFISecurityOperation,      //配置wifi的加密模式
    mk_cu_taskConfigWIFISSIDOperation,          //配置wifi的ssid
    mk_cu_taskConfigWIFIPasswordOperation,      //配置wifi的密码
    mk_cu_taskConfigWIFIEAPTypeOperation,       //配置wifi的EAP类型
    mk_cu_taskConfigWIFIEAPUsernameOperation,   //配置wifi的EAP用户名
    mk_cu_taskConfigWIFIEAPPasswordOperation,   //配置wifi的EAP密码
    mk_cu_taskConfigWIFIEAPDomainIDOperation,   //配置wifi的EAP域名ID
    mk_cu_taskConfigWIFIVerifyServerStatusOperation,    //配置wifi是否校验服务器
    mk_cu_taskConfigWIFICAFileOperation,                //配置WIFI CA证书
    mk_cu_taskConfigWIFIClientCertOperation,            //配置WIFI设备证书
    mk_cu_taskConfigWIFIClientPrivateKeyOperation,      //配置WIFI私钥
    mk_cu_taskConfigWIFIDHCPStatusOperation,                //配置Wifi DHCP开关
    mk_cu_taskConfigWIFIIpInfoOperation,                    //配置Wifi IP地址相关信息
    mk_cu_taskConfigNetworkTypeOperation,                   //配置网络接口类型
    mk_cu_taskConfigEthernetDHCPStatusOperation,            //配置Ethernet DHCP开关
    mk_cu_taskConfigEthernetIpInfoOperation,                //配置Ethernet IP地址相关信息
    
#pragma mark - MQTT Params
    mk_cu_taskConfigServerHostOperation,        //配置MQTT服务器域名
    mk_cu_taskConfigServerPortOperation,        //配置MQTT服务器端口
    mk_cu_taskConfigClientIDOperation,              //配置ClientID
    mk_cu_taskConfigServerUserNameOperation,        //配置服务器的登录用户名
    mk_cu_taskConfigServerPasswordOperation,        //配置服务器的登录密码
    mk_cu_taskConfigServerCleanSessionOperation,    //配置MQTT Clean Session
    mk_cu_taskConfigServerKeepAliveOperation,       //配置MQTT KeepAlive
    mk_cu_taskConfigServerQosOperation,             //配置MQTT Qos
    mk_cu_taskConfigSubscibeTopicOperation,         //配置Subscribe topic
    mk_cu_taskConfigPublishTopicOperation,          //配置Publish topic
    mk_cu_taskConfigLWTStatusOperation,             //配置LWT开关
    mk_cu_taskConfigLWTQosOperation,                //配置LWT Qos
    mk_cu_taskConfigLWTRetainOperation,             //配置LWT Retain
    mk_cu_taskConfigLWTTopicOperation,              //配置LWT topic
    mk_cu_taskConfigLWTPayloadOperation,            //配置LWT payload
    mk_cu_taskConfigConnectModeOperation,           //配置MTQQ服务器通信加密方式
    mk_cu_taskConfigCAFileOperation,                //配置CA证书
    mk_cu_taskConfigClientCertOperation,            //配置设备证书
    mk_cu_taskConfigClientPrivateKeyOperation,      //配置私钥
        
#pragma mark - 过滤参数
    mk_cu_taskConfigRssiFilterValueOperation,                   //配置扫描RSSI过滤
    mk_cu_taskConfigFilterRelationshipOperation,                //配置扫描过滤逻辑
    mk_cu_taskConfigFilterMACAddressListOperation,           //配置MAC过滤规则
    mk_cu_taskConfigFilterAdvNameListOperation,             //配置Adv Name过滤规则
    
#pragma mark - 蓝牙广播参数
    mk_cu_taskConfigAdvertiseBeaconStatusOperation,         //配置iBeacon开关
    mk_cu_taskConfigBeaconMajorOperation,                   //配置iBeacon major
    mk_cu_taskConfigBeaconMinorOperation,                   //配置iBeacon minor
    mk_cu_taskConfigBeaconUUIDOperation,                    //配置iBeacon UUID
    mk_cu_taskConfigAdvIntervalOperation,                   //配置广播频率
    mk_cu_taskConfigTxPowerOperation,                       //配置Tx Power
    mk_cu_taskConfigBeaconRssiOperation,                        //配置Beacon Rssi@1m
    
#pragma mark - 计电量参数
    mk_cu_taskConfigMeteringSwitchOperation,                //配置计量数据上报开关
    mk_cu_taskConfigPowerReportIntervalOperation,           //配置电量数据上报间隔
    mk_cu_taskConfigEnergyReportIntervalOperation,          //配置电能数据上报间隔
    mk_cu_taskConfigLoadDetectionNotificationStatusOperation,   //配置负载检测通知开关
};

