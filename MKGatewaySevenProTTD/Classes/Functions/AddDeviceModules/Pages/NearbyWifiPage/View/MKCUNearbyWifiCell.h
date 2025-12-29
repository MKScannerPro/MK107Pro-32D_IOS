//
//  MKCUNearbyWifiCell.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/9/5.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCUNearbyWifiCellModel : NSObject

@property (nonatomic, copy)NSString *ssid;

@property (nonatomic, copy)NSString *bssid;

@property (nonatomic, strong)NSNumber *rssi;

@end

@interface MKCUNearbyWifiCell : MKBaseCell

@property (nonatomic, strong)MKCUNearbyWifiCellModel *dataModel;

+ (MKCUNearbyWifiCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
