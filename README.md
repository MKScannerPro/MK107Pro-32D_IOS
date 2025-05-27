# MK107Pro-32D iOS Software Development Kit Guide

* This SDK support the company’s MK107Pro-32D products.The SDK is divided into two parts. SDK/BLE is the Bluetooth part, which is used to configure the device with MQTT server information and networked wifi information. When the device is successfully connected to the network, the SDK/MQTT part is used to communicate with the device.

# Design instructions

* SDK/BLE depends on the third-party component `MKBaseBleModule`. When the device is in Bluetooth broadcast mode, you can get the current broadcast device list through `MKCUCentralManager` and connect to the devices in the list. You can use the API in `MKCUInterface+MKCUConfig` to complete the configuration of the device's MQTT server information and networked wifi information.
* SDK/MQTT depends on the third-party component `MKBaseMQTTModule`. After the device is successfully connected to the network, it can only communicate with the outside world through MQTT. `MKCUMQTTDataManager` can complete the APP side to connect to the MQTT server, manage the topic of MQTT communication, send data to the MQTT server to send data and include some data actively reported by the device, `MKCUMQTTInterface` Contains the API for MQTT communication between the APP and the device.


# Get Started

### Development environment:

* Xcode9+， Please use Xcode9 or high version to develop;
* iOS14, we limit the minimum iOS system version to 14.0；

### Import to Project

#### 1. Add bluttooth SDK to your project.
Copy the SDK/BLE folder to your project and then add the `MKBaseBleModule`(through cocoapods) to your project.

* <font color=#FF0000 face="黑体">You need add the string to "info.plist" file of your project: Privacy - Bluetooth Peripheral Usage Description - "your description". as the screenshot below.</font>

* <font color=#FF0000 face="黑体">You need to add a string to the project's info.plist file: Privacy-Bluetooth Always Usage Description-"Your usage description".</font>

#### 2. Add MQTT SDK to your project.
Copy the SDK/MQTT folder to your project and then add the `MKBaseMQTTModule`(through cocoapods) to your project.

## Start Developing

### SDK/BLE

#### Get sharedInstance of Manager

First of all, the developer should get the sharedInstance of Manager:

```
MKCUCentralManager *manager = [MKCUCentralManager shared];
```

##### 1.Scanning

**If the manager.delegate has been set, implement the following method to obtain the scanned device list:**

```
/// Scan to new device.
/// @param deviceModel /*@{
    @"rssi":rssi,
        @"peripheral":peripheral,
        @"deviceName":(advDic[CBAdvertisementDataLocalNameKey] ? advDic[CBAdvertisementDataLocalNameKey] : @""),
        @"macAddress":macAddress,
        @"deviceType":deviceType,
        @"connectable":advDic[CBAdvertisementDataIsConnectable],
}*/
- (void)mk_cu_receiveDevice:(NSDictionary *)deviceModel {

}
```

##### 2.Connect to device

**Connect through the following methods in `MKCUCentralManager`:**



```
/// Connect device function
/// @param trackerModel Model
/// @param password Device connection password,8 characters long ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 password:(nonnull NSString *)password
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;
```

##### 3.Configuration parameter

* `MKCUInterface+MKCUConfig.h` contains various MQTT parameter settings. Note: cu_enterSTAModeWithSucBlock:failedBlock: must be called after all parameters are sent to the device. After the device receives this command, it will end the Bluetooth state to connect to the MQTT server.


### SDK/MQTT

#### Get sharedInstance of Manager
First of all, the developer should get the sharedInstance of Manager:

```
MKCUMQTTServerManager *manager = [MKCUMQTTServerManager shared];
```

##### 1.Connect to MQTT server

**Connect through the following methods in `MKMQTTServerManager`:**

```
/** Connects to the MQTT broker and stores the parameters for subsequent reconnects
 * @param host specifies the hostname or ip address to connect to. Defaults to @"localhost".
 * @param port specifies the port to connect to
 * @param tls specifies whether to use SSL or not
 * @param keepalive The Keep Alive is a time interval measured in seconds. The MQTTClient ensures that the interval between Control Packets being sent does not exceed the Keep Alive value. In the  absence of sending any other Control Packets, the Client sends a PINGREQ Packet.
 * @param clean specifies if the server should discard previous session information.
 * @param auth specifies the user and pass parameters should be used for authenthication
 * @param user an NSString object containing the user's name (or ID) for authentication. May be nil.
 * @param pass an NSString object containing the user's password. If userName is nil, password must be nil as well.
 * @param will indicates whether a will shall be sent
 * @param willTopic the Will Topic is a string, may be nil
 * @param willMsg the Will Message, might be zero length or nil
 * @param willQos specifies the QoS level to be used when publishing the Will Message.
 * @param willRetainFlag indicates if the server should publish the Will Messages with retainFlag.
 * @param clientId The Client Identifier identifies the Client to the Server. If nil, a random clientId is generated.
 * @param securityPolicy A custom SSL security policy or nil.
 * @param certificates An NSArray of the pinned certificates to use or nil.
 * @param protocolLevel Protocol version of the connection.
 * @param connectHandler Called when first connected or if error occurred. It is not called on subsequent internal reconnects.
 */

- (void)connectTo:(NSString *)host
             port:(NSInteger)port
              tls:(BOOL)tls
        keepalive:(NSInteger)keepalive
            clean:(BOOL)clean
             auth:(BOOL)auth
             user:(NSString *)user
             pass:(NSString *)pass
             will:(BOOL)will
        willTopic:(NSString *)willTopic
          willMsg:(NSData *)willMsg
          willQos:(MQTTQosLevel)willQos
   willRetainFlag:(BOOL)willRetainFlag
     withClientId:(NSString *)clientId
   securityPolicy:(MQTTSSLSecurityPolicy *)securityPolicy
     certificates:(NSArray *)certificates
    protocolLevel:(MQTTProtocolVersion)protocolLevel
   connectHandler:(MQTTConnectHandler)connectHandler;
```

##### 2.Subscribe and unsubscribe topic

**Connect through the following methods in `MKCUMQTTDataManager`:**

```

/**
 Subscribe the topic

 @param topicList topicList
 */
- (void)subscriptions:(NSArray <NSString *>*)topicList;

/**
 Unsubscribe the topic
 
 @param topicList topicList
 */
- (void)unsubscriptions:(NSArray <NSString *>*)topicList;

```

##### 3.The data actively reported by the device is obtained from the notification defined in `MKCUMQTTDataManager`:

* 1.When the connection state between the APP and the MQTT server changes, a `MKCUMQTTSessionManagerStateChangedNotification notification` is thrown.
* 2.The APP receives any data reported by the device and throws a notification `MKCUReceiveDeviceNetStateNotification` to indicate that the device is online.
* 3.Device OTA result notification: `MKCUReceiveDeviceOTAResultNotification`.
* 4.Notification of the result of device restoration to factory settings: `MKCUReceiveDeviceResetByButtonNotification`.
* 5.Bluetooth data report notification scanned by the device: `MKCUReceiveDeviceDatasNotification`.


#### API

`MKCUMQTTInterface` encapsulates the API for MQTT communication between APP and device.




# Change log

* 20250527 first version;
