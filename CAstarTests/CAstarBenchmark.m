//
//  CAstarBenchmark.m
//  CAstar
//
//  Created by Pelle on 2014-04-30.
//  Copyright (c) 2014 MagerValp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CASMutableArrayHeap.h"
#import "CASCArrayHeap.h"
#import "CASCAsmHeap.h"

const int batchSize = 128;

@interface CAstarBenchmark : XCTestCase {
    uint8_t buffer[1000 * batchSize];
}

@end

@implementation CAstarBenchmark

- (void)setUp
{
    [super setUp];
    arc4random_buf(buffer, sizeof(buffer));
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBenchmarkMutableArray
{
    CASMutableArrayHeap *heap = [[CASMutableArrayHeap alloc] init];
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    for (int offset = 0; offset < sizeof(buffer); offset += batchSize) {
        for (int i = 0; i < batchSize; i++) {
            [heap push:[NSNumber numberWithInt:(int)buffer[offset + i]]];
        }
        while (heap.size) {
            [heap pop];
        }
    }
    NSTimeInterval duration = [NSDate timeIntervalSinceReferenceDate] - start;
    NSLog(@"CASMutableArrayHeap %lu * %d push/pop = %.2f ms", sizeof(buffer) / batchSize, batchSize, duration * 1000.0);
    XCTAssertTrue(TRUE, @"Always succeeds");
}

- (void)testBenchmarkCArray
{
    CASCArrayHeap *heap = [[CASCArrayHeap alloc] init];
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    for (int offset = 0; offset < sizeof(buffer); offset += batchSize) {
        for (int i = 0; i < batchSize; i++) {
            [heap push:buffer[offset + i]];
        }
        while (heap.size) {
            [heap pop];
        }
    }
    NSTimeInterval duration = [NSDate timeIntervalSinceReferenceDate] - start;
    NSLog(@"CASCArrayHeap %lu * %d push/pop = %.2f ms", sizeof(buffer) / batchSize, batchSize, duration * 1000.0);
    XCTAssertTrue(TRUE, @"Always succeeds");
}

- (void)testBenchmarkCAsm
{
    CASCAsmHeap *heap = [[CASCAsmHeap alloc] init];
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    for (int offset = 0; offset < sizeof(buffer); offset += batchSize) {
        for (int i = 0; i < batchSize; i++) {
            [heap push:buffer[offset + i]];
        }
        while (heap.size) {
            [heap pop];
        }
    }
    NSTimeInterval duration = [NSDate timeIntervalSinceReferenceDate] - start;
    NSLog(@"CASCAsmHeap %lu * %d push/pop = %.2f ms", sizeof(buffer) / batchSize, batchSize, duration * 1000.0);
    XCTAssertTrue(TRUE, @"Always succeeds");
}

@end
