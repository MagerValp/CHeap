//
//  CASArrayHeap.h
//  CAstar
//
//  Created by Pelle on 2014-04-30.
//  Copyright (c) 2014 MagerValp. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ARRAY_HEAP_MAX_SIZE 1024

@interface CASCArrayHeap : NSObject {
    int _tree[ARRAY_HEAP_MAX_SIZE];
    int _treeSize;
}

- (int)size;
- (void)push:(int)value;
- (int)pop;

@end
