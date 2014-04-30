//
//  CASCAsmHeap.h
//  CAstar
//
//  Created by Pelle on 2014-04-30.
//  Copyright (c) 2014 MagerValp. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ASM_HEAP_MAX_SIZE 128

@interface CASCAsmHeap : NSObject {
    uint8_t _tree[ASM_HEAP_MAX_SIZE];
    uint8_t _treeSize;
}

- (uint8_t)size;
- (void)push:(uint8_t)value;
- (uint8_t)pop;

@end
