//
//  GrafHelper.h
//  Graph IS Laba 1
//
//  Created by Михаил Луцкий on 15.10.2017.
//  Copyright © 2017 LWTS LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrafTableRow.h"

/**
 Статический класс помощник, для выполнения поисковых операций по массивам граффа
 */
@interface GrafHelper : NSObject

+ (BOOL) isContainXValue:(NSInteger) xValue inGrafTable:(NSArray<GrafTableRow>*)grafTable;

@end
