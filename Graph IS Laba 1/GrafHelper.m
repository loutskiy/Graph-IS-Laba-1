//
//  GrafHelper.m
//  Graph IS Laba 1
//
//  Created by Михаил Луцкий on 15.10.2017.
//  Copyright © 2017 LWTS LLC. All rights reserved.
//

#import "GrafHelper.h"

@implementation GrafHelper

+ (BOOL)isContainXValue:(NSInteger)xValue inGrafTable:(NSArray<GrafTableRow> *)grafTable {
    for (GrafTableRow *gtr in grafTable) {
        if (gtr.X == xValue) return TRUE;
    }
    return FALSE;
}

@end
