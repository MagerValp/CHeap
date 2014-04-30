//
//  CASArrayHeap.m
//  CAstar
//
//  Created by Pelle on 2014-04-30.
//  Copyright (c) 2014 MagerValp. All rights reserved.
//

#import "CASCArrayHeap.h"

@implementation CASCArrayHeap

- (id)init
{
    self = [super init];
    if (self) {
        _treeSize = 0;
    }
    return self;
}

- (NSString *)description
{
    NSMutableArray *numbers = [[NSMutableArray alloc] init];
    for (int i = 0; i < _treeSize; i++) {
        [numbers addObject:[NSNumber numberWithInt:_tree[i]]];
    }
    return [NSString stringWithFormat:@"<CASArrayHeap with %d elements: %@>", (int)_treeSize, [numbers componentsJoinedByString:@", "]];
}



- (int)size
{
    return _treeSize;
}

- (void)swap:(int)x with:(int)y
{
    int temp = _tree[x];
    _tree[x] = _tree[y];
    _tree[y] = temp;
}

#define heap_parent(i) ((int)(((i) - 1) / 2))

- (void)push:(int)value
{
    int currentIndex = _treeSize;
    _tree[_treeSize++] = value;
    int newIndex = heap_parent(currentIndex);
    while (currentIndex != 0 && _tree[currentIndex] < _tree[newIndex]) {
        [self swap:currentIndex with:newIndex];
        currentIndex = newIndex;
        newIndex = heap_parent(currentIndex);
    }
}

#define heap_left_child(i) ((int)(((i) * 2) + 1))
#define heap_right_child(i) ((int)(((i) * 2) + 2))

- (int)pop
{
    // Save the item at the top so we can return it.
    int topValue = _tree[0];
    // Remove the item at the bottom of the tree.
    int bottomValue = _tree[--_treeSize];
    // Move it to the top of the tree.
    _tree[0] = bottomValue;
    // Heapify the tree.
    int currentIndex = 0;
    int newIndex, leftIndex, rightIndex;
    for (;;) {
        leftIndex = heap_left_child(currentIndex);
        rightIndex = heap_right_child(currentIndex);
        newIndex = currentIndex;
        if (leftIndex < _treeSize && _tree[newIndex] > _tree[leftIndex]) {
            newIndex = leftIndex;
        }
        if (rightIndex < _treeSize && _tree[newIndex] > _tree[rightIndex]) {
            newIndex = rightIndex;
        }
        if (newIndex == currentIndex) {
            return topValue;
        }
        [self swap:currentIndex with:newIndex];
        currentIndex = newIndex;
    }
}

@end
