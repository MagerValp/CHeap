//
//  CASCAsmHeap.m
//  CAstar
//
//  Created by Pelle on 2014-04-30.
//  Copyright (c) 2014 MagerValp. All rights reserved.
//

#import "CASCAsmHeap.h"

@implementation CASCAsmHeap

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



- (uint8_t)size
{
    return _treeSize;
}

// Swap tree node at x with the item at y.
- (void)swap:(uint8_t)x with:(uint8_t)y
{
    uint8_t a;
    uint8_t temp;
    
    a = _tree[x];
    temp = a;
    a = _tree[y];
    _tree[x] = a;
    a = temp;
    _tree[y] = a;
}

- (void)push:(uint8_t)value
{
    uint8_t a, x, y;
    
    // Add value to the bottom of the heap.
    x = _treeSize;
    _tree[x] = value;
    _treeSize++;
    // Set y to the parent node = (x - 1) / 2.
    a = x;
    a -= 1;
    a /= 2;
    y = a;
    for (;;) {
        // If x is at the top of the heap, we're done.
        if (x == 0) {
            break;
        }
        // If x is larger than its parent, we're done.
        if (_tree[x] > _tree[y]) {
            break;
        }
        // Swap x with its parent y.
        [self swap:x with:y];
        // Set x to point at its parent.
        a = y;
        x = a;
        // Set y to the new parent node.
        a -= 1;
        a /= 2;
        y = a;
    }
}

- (uint8_t)pop
{
    uint8_t a, x, y;
    uint8_t topValue;
    uint8_t currentIndex;
    
    // Save the item at the top so we can return it.
    a = _tree[0];
    topValue = a;
    // Remove the item at the bottom of the tree.
    _treeSize -= 1;
    if (_treeSize == 0) {
        a = topValue;
        return a;
    }
    y = _treeSize;
    a = _tree[y];
    // Move it to the top of the tree.
    _tree[0] = a;
    // Heapify the tree.
    currentIndex = 0;
    for (;;) {
        x = currentIndex;
        // Left child is at x * 2 + 1.
        a = x;
        a *= 2;
        a += 1;
        y = a;
        if (y < _treeSize) {
            if (_tree[x] > _tree[y]) {
                a = y;
                x = a;
            }
            // Right child is at x * 2 + 2, or left + 1.
            y++;
            if (y < _treeSize) {
                if (_tree[x] > _tree[y]) {
                    a = y;
                    x = a;
                }
            }
        }
        if (x == currentIndex) {
            a = topValue;
            return a;
        }
        y = currentIndex;
        [self swap:x with:y];
        currentIndex = x;
    }
}

@end
