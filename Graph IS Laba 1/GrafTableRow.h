//
//  GrafTableRow.h
//  Graph IS Laba 1
//
//  Created by Михаил Луцкий on 15.10.2017.
//  Copyright © 2017 LWTS LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Протокол строки
 */
@protocol GrafTableRow;

/**
 Объект строки таблицы обработанного граффа с X, open, closed
 */
@interface GrafTableRow : NSObject

/**
 Значение X
 */
@property (nonatomic, readwrite) NSInteger X;

/**
 Массив open
 */
@property (nonatomic, copy) NSArray *open;

/**
 Массив closed
 */
@property (nonatomic, copy) NSArray *closed;

@end
