//
//  Constants.h
//  BridgeApp
//
//  Created by Shrikar Archak on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#ifndef BridgeApp_Constants_h
#define BridgeApp_Constants_h
#import <UIKit/UIKit.h>
#pragma Job Related

FOUNDATION_EXPORT NSString *const JOB_TYPE;
FOUNDATION_EXPORT NSString *const TITLE;
FOUNDATION_EXPORT NSString *const SUMMARY;
FOUNDATION_EXPORT NSString *const PRICE;
FOUNDATION_EXPORT NSString *const DUE_DATE;
FOUNDATION_EXPORT NSString *const CATEGORY;
FOUNDATION_EXPORT NSString *const JOBSTATUS;
FOUNDATION_EXPORT NSString *const OWNER;

#pragma User Related
FOUNDATION_EXPORT NSString *const USERNAME;
FOUNDATION_EXPORT NSString *const PASSWORD;
FOUNDATION_EXPORT NSString *const USERTYPE;
FOUNDATION_EXPORT NSString *const BUSINESSNAME;


#pragma Notifications
FOUNDATION_EXPORT NSString *const JOBSTATUSCHANGED;


#pragma color
extern UIColor const *navBarColor;
extern UIColor const *headerBarColor;
extern UIColor const *tableViewCellColor;
extern UIColor const *textColor;

#define NAVBARCOLOR [UIColor colorWithRed:218.0/255.0 green:80.0/255.0 blue:14.0/255.0 alpha:1.0]
#define HEADERBARCOLOR [UIColor colorWithRed:0.827 green:0.807 blue:0.777 alpha:1.0]
#define TABLEVIEWCELLCOLOR [UIColor colorWithRed:246.0/255.0 green:241.0/255.0 blue:234.0/255.0 alpha:1.0]
#define NAVTEXTCOLOR [UIColor colorWithRed:246.0/255.0 green:241.0/255.0 blue:234.0/255.0 alpha:1.0]
#define TEXTCOLOR [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1.0]
#endif
