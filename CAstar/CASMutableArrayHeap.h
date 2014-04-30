//
//  CASLouderHeap.h
//  CAstar
//
//  Created by Pelle on 2014-04-29.
//  Copyright (c) 2014 MagerValp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CASMutableArrayHeap : NSObject

@property NSMutableArray *tree;

- (int)size;
- (void)push:(NSNumber *)value;
- (NSNumber *)pop;

@end
