//
//  PrintConsole.h
//  Graph IS Laba 1
//
//  Created by Михаил Луцкий on 13.10.2017.
//  Copyright © 2017 LWTS LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Graf.h"

/**
 Класс для работы с консолью
 */
@interface PrintConsole : NSObject

/**
 Метод выводит в консоль таблицу с X, open и closed значениями

 @param grafTable массив объектов GrafTableRow
 */
+ (void) showOpenClosedTable:(NSArray<GrafTableRow>*)grafTable;

/**
 Метод выводит в консоль применяемый тип поиска

 @param type тип поиска
 */
+ (void) showType:(TypeOfSearch)type;

/**
 Метод выводит в консоль кратчайший путь из начальной точки в заданную

 @param path массив с вершинами пути
 @param vertex конечная вершина
 */
+ (void) showShortPath:(NSMutableArray*)path toVertex:(NSInteger)vertex;

@end
