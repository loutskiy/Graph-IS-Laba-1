//
//  GrafRow.h
//  Graph IS Laba1
//
//  Created by Михаил Луцкий on 09.10.2017.
//  Copyright © 2017 LWTS LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Класс граф-строки
 */
@interface GrafRow : NSObject

/**
 Метод инициализирует строку матрицы смежности графа

 @param array Массив элементов строки
 @param index индекс строки в матрице смежности
 @return объект строки
 */
- (instancetype) initGrafRowFromArray:(NSArray *)array andIndex:(NSInteger)index;

/**
 Индекс строки
 */
@property (nonatomic, readonly) NSInteger indexOfRow;

/**
 Массив элементов строки
 */
@property (nonatomic, strong) NSArray *row;

@end
