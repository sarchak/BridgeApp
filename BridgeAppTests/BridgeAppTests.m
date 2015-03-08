//
//  BridgeAppTests.m
//  BridgeAppTests
//
//  Created by Shrikar Archak on 3/4/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
//#import "ParseClient.h"
//#import "User.h"
//#import "Job.h"
//#import "ConversationThread.h"
//#import "Message.h"
//#import "Asset.h"

@interface BridgeAppTests : XCTestCase

@property (atomic, assign) BOOL waitingAsyncCall;

@end

@implementation BridgeAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

//- (void)testParseSignup {
//    
//    ParseClient *p = [ParseClient sharedInstance];
//    User* user = [[User alloc] init];
//    user.email =@"emrahseker+bridge001@gmail.com";
//    user.password = @"test1234";
//    
//    [self runAsyncCallTest:^{
//        [p signUp:user completion:^(NSError *error) {
//            if (error) {
//                XCTFail(@"Parse signup test failed: %@", error);
//            }
//            else {
//                NSLog(@"Signup succeeded.");
//            }
//            self.waitingAsyncCall = false;
//        }];
//    }];
//    
//}
//- (void)testParseLogin {
//    ParseClient *p = [ParseClient sharedInstance];
//    User* user = [[User alloc] init];
//    user.email =@"emrahseker+bridge001@gmail.com";
//    user.password = @"test1234";
//    
//    [self runAsyncCallTest:^{
//        [p login:user.email password:user.password completion:^(NSError *error) {
//            if (error) {
//                XCTFail(@"Parse login test failed: %@", error);
//            }
//            else {
//                NSLog(@"Parse Login test succeeded.");
//            }
//            
//            self.waitingAsyncCall = false;
//        }];
//    }];
//}
//
//- (void)testParseUpdateUser {
//    ParseClient *p = [ParseClient sharedInstance];
//    User* user = [[User alloc] init];
//    user.email =@"emrahseker+bridge001@gmail.com";
//    user.password = @"test1234";
//    
//    [self runAsyncCallTest:^{
//        [p login:user.email password:user.password completion:^(NSError *error) {
//            XCTAssert(error == nil, @"Login failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//    
//    user = [User currentUser];
//    user.profileImageURL = @"testing";
//    [self runAsyncCallTest:^{
//        [p updateUser:user completion:^(NSError *error) {
//            XCTAssert(error == nil, @"Update user failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//    
//    user = [User currentUser];
//    XCTAssert([user.profileImageURL isEqual:@"testing"], @"Verify profile image url");
//    
//}
//
//- (void)testAddEditDeleteJob {
//    Job* job = [[Job alloc] init];
//    job.title = @"test title";
//    
//    [self runAsyncCallTest:^{
//        [job saveWithCompletion:^(NSError *error) {
//            XCTAssert(error == nil, @"Job creation failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//    XCTAssert(job.createdAt != nil && ![job.createdAt isEqual:[NSNull null]], @"Verify task creation time");
//    
//    NSDate* oldUpdateDate = job.updatedAt;
//    
//    job.title = @"test title 2";
//    [self runAsyncCallTest:^{
//        [job saveWithCompletion:^(NSError *error) {
//            XCTAssert(error == nil, @"Job update failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//    
//    XCTAssert([job.title isEqual:@"test title 2" ], "Job title should be different");
//    XCTAssert(oldUpdateDate != job.updatedAt, "Job update time should be different");
//    
//    
//    [self runAsyncCallTest:^{
//        [job deleteWithCompletion:^(NSError *error) {
//            XCTAssert(error == nil, @"Job delete failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//}
//
//- (void)testAddEditDeleteConversationThread {
//    ConversationThread* thread = [[ConversationThread alloc] init];
//    thread.businessId = @"1234";
//    thread.freelancerId = @"5678";
//    thread.jobId = @"123456789";
//    
//    [self runAsyncCallTest:^{
//        [thread saveWithCompletion:^(NSError *error) {
//            XCTAssert(error == nil, @"Thread creation failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//    XCTAssert(thread.createdAt != nil && ![thread.createdAt isEqual:[NSNull null]], @"Verify thread creation time");
//    
//    NSDate* oldUpdateDate = thread.updatedAt;
//    
//    thread.businessId = @"12345678";
//    [self runAsyncCallTest:^{
//        [thread saveWithCompletion:^(NSError *error) {
//            XCTAssert(error == nil, @"Thread update failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//    
//    XCTAssert([thread.businessId isEqual:@"12345678"], "Thread business id should be different");
//    XCTAssert(oldUpdateDate != thread.updatedAt, "Thread update time should be different");
//    
//    [self runAsyncCallTest:^{
//        [thread deleteWithCompletion:^(NSError *error) {
//            XCTAssert(error == nil, @"Job delete failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//}
//
//- (void)testAddEditDeleteMessage {
//    Message* message = [[Message alloc] init];
//    message.message = @"yo";
//    message.senderId = @"1234";
//    message.threadId = @"123456789";
//    
//    [self runAsyncCallTest:^{
//        [message saveWithCompletion:^(NSError *error) {
//            XCTAssert(error == nil, @"Message creation failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//    XCTAssert(message.createdAt != nil && ![message.createdAt isEqual:[NSNull null]], @"Verify message creation time");
//    
//    NSDate* oldUpdateDate = message.updatedAt;
//    
//    message.message = @"yo yo";
//    [self runAsyncCallTest:^{
//        [message saveWithCompletion:^(NSError *error) {
//            XCTAssert(error == nil, @"Message update failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//    
//    XCTAssert([message.message isEqual:@"yo yo"], "Message should be different");
//    XCTAssert(oldUpdateDate != message.updatedAt, "Message update time should be different");
//    
//    
//    [self runAsyncCallTest:^{
//        [message deleteWithCompletion:^(NSError *error) {
//            XCTAssert(error == nil, @"Job delete failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//}
//
//- (void)testAddEditDeleteAsset {
//    Asset* asset = [[Asset alloc] init];
//    asset.ownerId = @"1234";
//    asset.assetURL = @"http";
//    
//    [self runAsyncCallTest:^{
//        [asset saveWithCompletion:^(NSError *error) {
//            XCTAssert(error == nil, @"Asset creation failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//    XCTAssert(asset.createdAt != nil && ![asset.createdAt isEqual:[NSNull null]], @"Verify asset creation time");
//    
//    NSDate* oldUpdateDate = asset.updatedAt;
//    
//    asset.assetURL = @"box";
//    [self runAsyncCallTest:^{
//        [asset saveWithCompletion:^(NSError *error) {
//            XCTAssert(error == nil, @"Asset update failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//    
//    XCTAssert([asset.assetURL isEqual:@"box"], "Asset url should be different");
//    XCTAssert(oldUpdateDate != asset.updatedAt, "Asset update time should be different");
//    
//    
//    [self runAsyncCallTest:^{
//        [asset deleteWithCompletion:^(NSError *error) {
//            XCTAssert(error == nil, @"Asset delete failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//    
//    [self runAsyncCallTest:^{
//        [asset findByIdWithCompletion:asset.objectId completion:^(DBModel* object, NSError *error) {
//            XCTAssert(error != nil, @"Asset lookup was expected to fail, but it didn't: %@", object);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//}
//
//- (void)testFindUser {
//    User* user = [[User alloc] init];
//    
//    NSMutableArray* filters = [[NSMutableArray alloc] init];
//    [filters addObject:[QueryFilter filterByField:@"objectId" operator:QueryFilterOperatorEquals value:@"emrahseker+aaa@gmail.com"]];
//    
//    [self runAsyncCallTest:^{
//        [user findWithCompletion:filters sortOptions:nil completion:^(NSArray *foundObjects, NSError *error) {
//            // check if expected objects were found
//            
//            
//            self.waitingAsyncCall = false;
//        }];
//    }];
//}
//
//- (void)testFindJob {
//    Job* user = [[Job alloc] init];
//    
//    NSMutableArray* filters = [[NSMutableArray alloc] init];
//    [filters addObject:[QueryFilter filterByField:@"title" operator:QueryFilterOperatorEquals value:@"test title 2"]];
//    [filters addObject:[QueryFilter filterByField:@"status" operator:QueryFilterOperatorEquals value:@0]];
//    
//    NSMutableArray* sortOptions = [[NSMutableArray alloc] init];
//    [sortOptions addObject:[QuerySortOption sortByFields:@"createdAt" direction:QuerySortDirectionDescending]];
//    
//    [self runAsyncCallTest:^{
//        [user findWithCompletion:filters sortOptions:sortOptions completion:^(NSArray *foundObjects, NSError *error) {
//            // check if expected objects were found
//            
//            
//            self.waitingAsyncCall = false;
//        }];
//    }];
//}
//
//- (void)testFindById {
//    Asset* asset = [[Asset alloc] init];
//    asset.ownerId = @"1234";
//    asset.assetURL = @"http";
//    
//    [self runAsyncCallTest:^{
//        [asset saveWithCompletion:^(NSError *error) {
//            XCTAssert(error == nil, @"Asset creation failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//    XCTAssert(asset.createdAt != nil && ![asset.createdAt isEqual:[NSNull null]], @"Verify asset creation time");
//    
//    Asset* asset2 = [[Asset alloc] init];
//    
//    [self runAsyncCallTest:^{
//        [asset2 findByIdWithCompletion:asset.objectId completion:^(DBModel* object, NSError *error) {
//            XCTAssert(object != nil, @"Asset lookup was expected to succeed, but it didn't: %@", error);
//            XCTAssert([object.objectId isEqual:asset.objectId], @"Found asset is not the one we were looking for: %@", object);
//            XCTAssert([object.updatedAt isEqual:asset.updatedAt], @"Found asset is not the one we were looking for: %@", object);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//    
//    [self runAsyncCallTest:^{
//        [asset deleteWithCompletion:^(NSError *error) {
//            XCTAssert(error == nil, @"Asset delete failed: %@", error);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//    
//    [self runAsyncCallTest:^{
//        [asset findByIdWithCompletion:asset.objectId completion:^(DBModel* object, NSError *error) {
//            XCTAssert(error != nil, @"Asset lookup was expected to fail, but it didn't: %@", object);
//            self.waitingAsyncCall = false;
//        }];
//    }];
//}
//
//-(void)runAsyncCallTest:(void (^)())testBlock  {
//    self.waitingAsyncCall = true;
//    testBlock();
//    while (self.waitingAsyncCall) {
//        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
//    }
//}

@end
