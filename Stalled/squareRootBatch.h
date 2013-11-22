//
//  squareRootBatch.h
//  Stalled
//
//  Created by Mewlan Musajan on 11/22/13.
//  Copyright (c) 2013 Mewlan Musajan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface squareRootBatch : NSObject
@property (assign, nonatomic) NSInteger max;
@property (assign, nonatomic) NSInteger current;

- (id)initWhithMaxNumber:(NSInteger)maxNumber;
- (BOOL)hasNext;
- (double)next;
- (float)percentCompeleted;
- (NSString *)percentCompeletedText;
@end
