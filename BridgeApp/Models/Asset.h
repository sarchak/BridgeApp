//
//  Asset.h
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "DBModel.h"

@interface Asset : DBModel

@property (nonatomic, strong) NSString* assetId;
@property (nonatomic, strong) NSString* ownerId;
@property (nonatomic, strong) NSString* assetURL;

@end
