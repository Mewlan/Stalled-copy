//
//  squareRootBatch.m
//  Stalled
//
//  Created by Mewlan Musajan on 11/22/13.
//  Copyright (c) 2013 Mewlan Musajan. All rights reserved.
//

#import "squareRootBatch.h"

#define kExceededMaxException @"ExceededMax"

@implementation squareRootBatch

- (id)initWhithMaxNumber:(NSInteger)maxNumber
{
    self = [super init];
    if (self) {
        self.current = 0;
        self.max = maxNumber;
    }
    return self;
}

- (BOOL)hasNext
{
    return self.current <= self.max;
}

- (double)next
{
    if (self.current > self.max)
        [NSException raise:kExceededMaxException format:@"Requested a calculation from compeleted batch"];
    return sqrt((double)++self.current);
    
}

- (float)percentCompeleted
{
    return (float)self.current / (float)self.max;
}

- (NSString *)percentCompeletedText
{
    return [NSString stringWithFormat:@"Square Root of %ld is %.6f",(long)self.current, sqrt((double)self.current)];
}


@end
