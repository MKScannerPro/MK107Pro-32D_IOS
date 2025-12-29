//
//  MKCUNetworkSsidSettingsCell.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/9/1.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCUNetworkSsidSettingsCellModel : NSObject

@property (nonatomic, copy)NSString *ssid;

@end

@protocol MKCUNetworkSsidSettingsCellDelegate <NSObject>

- (void)cu_networkSsidSettingsCell_ssidChanged:(NSString *)ssid;

- (void)cu_networkSsidSettingsCell_buttonPressed;

@end

@interface MKCUNetworkSsidSettingsCell : MKBaseCell

@property (nonatomic, strong)MKCUNetworkSsidSettingsCellModel *dataModel;

@property (nonatomic, weak)id <MKCUNetworkSsidSettingsCellDelegate>delegate;

+ (MKCUNetworkSsidSettingsCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
