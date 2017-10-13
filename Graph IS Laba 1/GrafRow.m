//
//  GrafRow.m
//  Graph IS Laba 1
//
//  Created by Михаил Луцкий on 09.10.2017.
//  Copyright © 2017 LWTS LLC. All rights reserved.
//

#import "GrafRow.h"

@implementation GrafRow

@synthesize indexOfRow = _indexOfRow;

- (instancetype)initGrafRowFromArray:(NSArray *)array andIndex:(NSInteger)index {
    self = [super init];
    if (self) {
        _indexOfRow = index;
        self.row = [array objectAtIndex:index];
    } return self;
}

@end
