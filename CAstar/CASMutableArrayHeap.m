//
//  CASLouderHeap.m
//  CAstar
//
//  Created by Pelle on 2014-04-29.
//  Copyright (c) 2014 MagerValp. All rights reserved.
//

#import "CASMutableArrayHeap.h"

@implementation CASMutableArrayHeap

- (id)init
{
    self = [super init];
    if (self) {
        self.buffer = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<CASLouderHeap with %d elements: %@>", self.size, [self.buffer componentsJoinedByString:@", "]];
}



- (int)size
{
    return (int)self.buffer.count;
}

- (void)swap:(NSUInteger)thisIndex with:(NSUInteger)thatIndex
{
    NSNumber *temp = self.buffer[thisIndex];
    self.buffer[thisIndex] = self.buffer[thatIndex];
    self.buffer[thatIndex] = temp;
}

#define heap_parent(i) ((NSUInteger)(((i) - 1) / 2))

- (void)insert:(int)value
{
    NSUInteger currentIndex = self.buffer.count;
    [self.buffer addObject:[NSNumber numberWithInt:value]];
    NSUInteger newIndex = heap_parent(currentIndex);
    while (currentIndex > 0 && self.buffer[currentIndex] < self.buffer[newIndex]) {
        [self swap:currentIndex with:newIndex];
        currentIndex = newIndex;
        newIndex = heap_parent(currentIndex);
    }
}

#define heap_left_child(i) (((i) * 2) + 1)
#define heap_right_child(i) (((i) * 2) + 2)

- (int)pop
{
    // Save the item at the top so we can return it.
    NSNumber *topNumber = self.buffer[0];
    int topInt = topNumber.intValue;
    // Remove the item at the bottom of the tree.
    NSNumber *bottomNumber = [self.buffer lastObject];
    [self.buffer removeLastObject];
    // Move it to the top of the tree.
    self.buffer[0] = bottomNumber;
    // Heapify the tree.
    NSUInteger currentIndex = 0;
    NSUInteger newIndex, leftIndex, rightIndex;
    for (;;) {
        leftIndex = heap_left_child(currentIndex);
        rightIndex = heap_right_child(currentIndex);
        if (leftIndex < self.size && self.buffer[currentIndex] > self.buffer[leftIndex]) {
            newIndex = leftIndex;
        } else {
            newIndex = currentIndex;
        }
        if (rightIndex < self.size && self.buffer[newIndex] > self.buffer[rightIndex]) {
            newIndex = rightIndex;
        }
        if (newIndex == currentIndex) {
            return topInt;
        }
        [self swap:currentIndex with:newIndex];
        currentIndex = newIndex;
    }
}

@end
