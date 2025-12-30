//
//  MKCUFilterCell.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCUFilterCellModel : NSObject

/// cell标识符
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger dataListIndex;

@property (nonatomic, strong)NSArray <NSString *>*dataList;

@end

@protocol MKCUFilterCellDelegate <NSObject>

- (void)cu_filterValueChanged:(NSInteger)dataListIndex index:(NSInteger)index;

@end

@interface MKCUFilterCell : MKBaseCell

@property (nonatomic, strong)MKCUFilterCellModel *dataModel;

@property (nonatomic, weak)id <MKCUFilterCellDelegate>delegate;

+ (MKCUFilterCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
