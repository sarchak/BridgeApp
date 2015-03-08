//
//  Asset.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "Asset.h"

@implementation Asset

-(Asset*)initWithDictionary:(NSDictionary*)dict {
    
    self = [super init];
    
    if (self) {
        [self updateWithDictionary:dict];
    }
    
    return self;
}

-(void)updateWithDictionary:(NSDictionary*) dict {
    [super updateWithDictionary:dict];
    
    self.ownerId = dict[@"ownerId"];
    self.assetURL = dict[@"assetURL"];
    
}

-(NSMutableDictionary*)toDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:(self.ownerId ?: [NSNull null]) forKey:@"ownerId"];
    [dict setObject:(self.assetURL ?: [NSNull null]) forKey:@"assetURL"];
    
    return dict;
}

-(NSString*)tableName {
    return @"Asset";
}


@end
