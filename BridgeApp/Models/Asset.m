//
//  Asset.m
//  BridgeApp
//
//  Created by Emrah Seker on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "Asset.h"

@implementation Asset

+(NSMutableArray*) assetsWithDictionaries:(NSArray*)dictionaries {
    NSMutableArray *assets = [[NSMutableArray alloc] init];
    Asset* temp = nil;
    
    for (NSDictionary* assetDict in dictionaries) {
        temp = [[Asset alloc] initWithDictionary:assetDict];
        [assets addObject:temp];
    }
    
    return assets;
}

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
    return [Asset tableName];
}

+(NSString*)tableName {
    return @"Asset";
}

-(NSArray*) includeKeys {
    return [Asset includeKeys];
}

+(NSArray*) includeKeys {
    return @[];
}

-(NSArray*)requiredFields {
    return @[
             @"ownerId",
             @"assetURL"
             ];
}


@end
