//
//  CASAppDelegate.m
//  CAstar
//
//  Created by Pelle on 2014-04-29.
//  Copyright (c) 2014 MagerValp. All rights reserved.
//

#import "CASAppDelegate.h"
#import "CASMutableArrayHeap.h"
#import "CASCArrayHeap.h"


@implementation CASAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    CASMutableArrayHeap *maheap = [[CASMutableArrayHeap alloc] init];
    [maheap insert:13];
    [maheap insert:2];
    [maheap insert:3];
    [maheap insert:19];
    [maheap insert:1];
    [maheap insert:4];
    [maheap insert:18];
    NSLog(@"heap = %@", maheap);
    NSLog(@"* %d", [maheap pop]);
    NSLog(@"* %d", [maheap pop]);
    NSLog(@"* %d", [maheap pop]);
    NSLog(@"* %d", [maheap pop]);
    NSLog(@"* %d", [maheap pop]);
    NSLog(@"* %d", [maheap pop]);
    NSLog(@"* %d", [maheap pop]);

    CASCArrayHeap *aheap = [[CASCArrayHeap alloc] init];
    [aheap insert:13];
    [aheap insert:2];
    [aheap insert:3];
    [aheap insert:19];
    [aheap insert:1];
    [aheap insert:4];
    [aheap insert:18];
    NSLog(@"aheap = %@", aheap);
    NSLog(@"* %d", [aheap pop]);
    NSLog(@"* %d", [aheap pop]);
    NSLog(@"* %d", [aheap pop]);
    NSLog(@"* %d", [aheap pop]);
    NSLog(@"* %d", [aheap pop]);
    NSLog(@"* %d", [aheap pop]);
    NSLog(@"* %d", [aheap pop]);
}

@end
