//
//  CASArrayHeap.h
//  CAstar
//
//  Created by Pelle on 2014-04-30.
//  Copyright (c) 2014 MagerValp. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ARRAY_HEAP_MAX_SIZE 128

@interface CASCArrayHeap : NSObject {
    unsigned char buffer[ARRAY_HEAP_MAX_SIZE];
    unsigned char bufSize;
}

- (int)size;
- (void)insert:(int)value;
- (int)pop;

@end
