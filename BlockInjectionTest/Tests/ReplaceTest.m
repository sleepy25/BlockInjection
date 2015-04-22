//
//  ReplaceTest.m
//  BlockInjectionTest
//
//  Created by ytokoro on 3/23/13.
//  Copyright (c) 2013 tokorom. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BILib.h"

#pragma mark - SubjectForReplace

@interface SubjectForDummy : NSObject
- (void)instanceMethod2:(id)arg;
@end

@interface SubjectForReplace : NSObject
- (void)instanceMethod:(id)arg;
+ (void)classMethod:(id)arg;
@end

@implementation SubjectForReplace

- (void)instanceMethod:(id)arg {
    NSLog(@"instanceMethod: %@", arg);
}

+ (void)classMethod:(id)arg {
    NSLog(@"classMethod: %@", arg);
}

@end

#pragma mark - ReplaceTest

@interface ReplaceTest : XCTestCase
@end

@implementation ReplaceTest

- (void)setUp {
    [super setUp];
    [BILib clear];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testReplaceImplementation {
    __block int i = 0;
    [BILib replaceImplementationForClass:[SubjectForReplace class]
                                selector:@selector(instanceMethod:)
                                   block:^{
                                   ++i;
                                   }];

    XCTAssertEqual(i, 0, @"i is invalid.");

    [[SubjectForReplace new] instanceMethod:@"hello!"];

    XCTAssertEqual(i, 1, @"i is invalid.");
}

- (void)testReplaceImplementationForNoMethods {
    __block int i = 0;
    [BILib replaceImplementationForClass:[SubjectForReplace class]
                                selector:@selector(instanceMethod2:)
                                   block:^{
                                   ++i;
                                   }];

    XCTAssertEqual(i, 0, @"i is invalid.");

    [[SubjectForReplace new] instanceMethod:@"hello!"];

    XCTAssertEqual(i, 0, @"i is invalid.");
}

- (void)testReplaceImplementationWithArg {
    __block NSString *got = nil;
    [BILib replaceImplementationForClass:[SubjectForReplace class]
                                selector:@selector(instanceMethod:)
                                   block:^(id target, id arg) {
                                   got = arg;
                                   }];

    XCTAssertNil(got, @"got is invalid.");

    [[SubjectForReplace new] instanceMethod:@"got!"];

    XCTAssertTrue([got isEqualToString:@"got!"], @"got is invalid: %@", got);
}

- (void)testReplaceWithName {
    __block int i = 0;
    [BILib replaceImplementationForClassName:@"SubjectForReplace"
                                  methodName:@"instanceMethod:"
                                       block:^{
                                       ++i;
                                       }];

    XCTAssertEqual(i, 0, @"i is invalid.");

    [[SubjectForReplace new] instanceMethod:@"hello!"];

    XCTAssertEqual(i, 1, @"i is invalid.");
}

- (void)testReplaceClassMethod {
    __block int i = 0;
    [BILib replaceImplementationForClass:[SubjectForReplace class]
                                selector:@selector(classMethod:)
                                   block:^{
                                   ++i;
                                   }];

    XCTAssertEqual(i, 0, @"i is invalid.");

    [SubjectForReplace classMethod:@"hello!"];

    XCTAssertEqual(i, 1, @"i is invalid.");
}

- (void)testReplaceAndInject {
    __block NSString *got = nil;
    [BILib replaceImplementationForClass:[SubjectForReplace class]
                                selector:@selector(instanceMethod:)
                                   block:^(id target, id arg) {
                                   got = arg;
                                   }];

    __block int i = 0;
    [BILib injectToClass:[SubjectForReplace class]
                selector:@selector(instanceMethod:)
              preprocess:^{
              ++i;
              }];

    XCTAssertNil(got, @"got is invalid.");
    XCTAssertEqual(i, 0, @"i is invalid.");

    [[SubjectForReplace new] instanceMethod:@"got!"];

    XCTAssertTrue([got isEqualToString:@"got!"], @"got is invalid: %@", got);
    XCTAssertEqual(i, 1, @"i is invalid.");
}
@end
