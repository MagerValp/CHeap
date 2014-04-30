//
//  CASMutableArrayHeap.m
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
        self.tree = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<CASMutableArrayHeap with %d elements: %@>", self.size, [self.tree componentsJoinedByString:@", "]];
}



- (int)size
{
    return (int)self.tree.count;
}

- (void)swap:(NSUInteger)thisIndex with:(NSUInteger)thatIndex
{
    NSNumber *temp = self.tree[thisIndex];
    self.tree[thisIndex] = self.tree[thatIndex];
    self.tree[thatIndex] = temp;
}

#define heap_parent(i) ((NSUInteger)(((i) - 1) / 2))

- (void)push:(NSNumber *)value
{
    NSUInteger currentIndex = self.tree.count;
    [self.tree addObject:value];
    NSUInteger newIndex = heap_parent(currentIndex);
    while (currentIndex > 0 && self.tree[currentIndex] < self.tree[newIndex]) {
        [self swap:currentIndex with:newIndex];
        currentIndex = newIndex;
        newIndex = heap_parent(currentIndex);
    }
}

#define heap_left_child(i) (((i) * 2) + 1)
#define heap_right_child(i) (((i) * 2) + 2)

- (NSNumber *)pop
{
    if (self.tree.count == 0) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"can't pop from empty heap" userInfo:nil];
    }
    // Save the item at the top so we can return it.
    NSNumber *topNumber = self.tree[0];
    // Remove the item at the bottom of the tree.
    NSNumber *bottomNumber = [self.tree lastObject];
    [self.tree removeLastObject];
    if (self.tree.count == 0) {
        return topNumber;
    }
    // Move it to the top of the tree.
    self.tree[0] = bottomNumber;
    // Heapify the tree.
    NSUInteger currentIndex = 0;
    NSUInteger newIndex, leftIndex, rightIndex;
    for (;;) {
        leftIndex = heap_left_child(currentIndex);
        rightIndex = heap_right_child(currentIndex);
        newIndex = currentIndex;
        if (leftIndex < self.size && self.tree[newIndex] > self.tree[leftIndex]) {
            newIndex = leftIndex;
        }
        if (rightIndex < self.size && self.tree[newIndex] > self.tree[rightIndex]) {
            newIndex = rightIndex;
        }
        if (newIndex == currentIndex) {
            return topNumber;
        }
        [self swap:currentIndex with:newIndex];
        currentIndex = newIndex;
    }
}

@end
