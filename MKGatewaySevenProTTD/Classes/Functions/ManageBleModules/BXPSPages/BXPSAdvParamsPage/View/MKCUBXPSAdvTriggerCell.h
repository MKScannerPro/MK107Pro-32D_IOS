//
//  MKCUBXPSAdvTriggerCell.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2025/2/13.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKCUBXPSAdvTriggerCellSlotType) {
    MKCUBXPSAdvTriggerCellSlotTypeUID,
    MKCUBXPSAdvTriggerCellSlotTypeURL,
    MKCUBXPSAdvTriggerCellSlotTypeTLM,
    MKCUBXPSAdvTriggerCellSlotTypeBeacon,
    MKCUBXPSAdvTriggerCellSlotTypeTHInfo,
    MKCUBXPSAdvTriggerCellSlotTypeSensorInfo,
    MKCUBXPSAdvTriggerCellSlotTypeNoData,
};

@interface MKCUBXPSAdvTriggerCellModel : NSObject

@property (nonatomic, assign)NSInteger slotIndex;

@property (nonatomic, assign)MKCUBXPSAdvTriggerCellSlotType slotType;

@property (nonatomic, copy)NSString *advInterval;

/*
 0:-20dBm
 1:-16dBm
 2:-12dBm
 3:-8dBm
 4:-4dBm
 5:0dBm
 6:3dBm
 7:4dBm
 8:6dBm
 */
@property (nonatomic, assign)NSInteger txPower;

- (CGFloat)fetchCellHeight;

@end

@protocol MKCUBXPSAdvTriggerCellDelegate <NSObject>

/// set按钮点击事件
/// - Parameters:
///   - index: index
///   - interval: 当前ADV interval
///   - txPower: 当前Tx Power
/*
 -20
 -16
 -12
 -8
 -4
 0
 3
 4
 6
 */
- (void)cu_BXPSAdvTriggerCell_setPressed:(NSInteger)index
                                interval:(NSString *)interval
                                 txPower:(NSInteger)txPower;

@end

@interface MKCUBXPSAdvTriggerCell : MKBaseCell

@property (nonatomic, weak)id <MKCUBXPSAdvTriggerCellDelegate>delegate;

@property (nonatomic, strong)MKCUBXPSAdvTriggerCellModel *dataModel;

+ (MKCUBXPSAdvTriggerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
