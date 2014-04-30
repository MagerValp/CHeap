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
        bufSize = 0;
    }
    return self;
}

- (NSString *)description
{
    NSMutableArray *numbers = [[NSMutableArray alloc] init];
    for (int i = 0; i < bufSize; i++) {
        [numbers addObject:[NSNumber numberWithInt:buffer[i]]];
    }
    return [NSString stringWithFormat:@"<CASArrayHeap with %d elements: %@>", (int)bufSize, [numbers componentsJoinedByString:@", "]];
}



- (int)size
{
    return bufSize;
}

- (void)swap:(unsigned char)x with:(unsigned char)y
{
    unsigned char temp = buffer[x];
    buffer[x] = buffer[y];
    buffer[y] = temp;
}

#define heap_parent(i) ((unsigned char)(((i) - 1) / 2))

- (void)insert:(int)value
{
    unsigned char currentIndex = bufSize;
    buffer[bufSize++] = (unsigned char)value;
    unsigned char newIndex = heap_parent(currentIndex);
    while (currentIndex != 0 && buffer[currentIndex] < buffer[newIndex]) {
        [self swap:currentIndex with:newIndex];
        currentIndex = newIndex;
        newIndex = heap_parent(currentIndex);
    }
}

#define heap_left_child(i) ((unsigned char)(((i) * 2) + 1))
#define heap_right_child(i) ((unsigned char)(((i) * 2) + 2))

- (int)pop
{
    // Save the item at the top so we can return it.
    unsigned char topValue = buffer[0];
    // Remove the item at the bottom of the tree.
    unsigned char bottomValue = buffer[--bufSize];
    // Move it to the top of the tree.
    buffer[0] = bottomValue;
    // Heapify the tree.
    unsigned char currentIndex = 0;
    unsigned char newIndex, leftIndex, rightIndex;
    for (;;) {
        leftIndex = heap_left_child(currentIndex);
        rightIndex = heap_right_child(currentIndex);
        if (leftIndex < bufSize && buffer[currentIndex] > buffer[leftIndex]) {
            newIndex = leftIndex;
        } else {
            newIndex = currentIndex;
        }
        if (rightIndex < bufSize && buffer[newIndex] > buffer[rightIndex]) {
            newIndex = rightIndex;
        }
        if (newIndex == currentIndex) {
            return (int)topValue;
        }
        [self swap:currentIndex with:newIndex];
        currentIndex = newIndex;
    }
}

@end
