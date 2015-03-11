//
//  NSUserDefaults+ChatSettings.h
//  BridgeApp
//
//  Created by Shrikar Archak on 3/11/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (ChatSettings)
+ (void)saveExtraMessagesSetting:(BOOL)value;
+ (BOOL)extraMessagesSetting;

+ (void)saveLongMessageSetting:(BOOL)value;
+ (BOOL)longMessageSetting;

+ (void)saveEmptyMessagesSetting:(BOOL)value;
+ (BOOL)emptyMessagesSetting;

+ (void)saveSpringinessSetting:(BOOL)value;
+ (BOOL)springinessSetting;

+ (void)saveOutgoingAvatarSetting:(BOOL)value;
+ (BOOL)outgoingAvatarSetting;

+ (void)saveIncomingAvatarSetting:(BOOL)value;
+ (BOOL)incomingAvatarSetting;

@end
