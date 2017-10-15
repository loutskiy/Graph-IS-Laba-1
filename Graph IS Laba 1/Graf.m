//
//  Graf.m
//  Graph IS Laba 1
//
//  Created by Михаил Луцкий on 09.10.2017.
//  Copyright © 2017 LWTS LLC. All rights reserved.
//

#import "Graf.h"
#import "GrafRow.h"

@interface Graf () {
    NSMutableArray *pathTemp; // Мутабельный массив временных путей
}

@end

@implementation Graf

- (instancetype)initWithGrafForArray:(NSArray *)array {
    self = [super init];
    if (self) {
        self.array2d = array;
        self.openArray = [NSMutableArray new];
        self.closedArray = [NSMutableArray new];
        self.paths = [NSMutableArray new];
        self.Xs = [NSMutableArray new];
    }
    return self;
}

/**
 Метод запускает обход строк для построения openClosed
 */
- (void) openClosedSearch {
    for (NSInteger i = 0; i < self.array2d.count; i++) {
        GrafRow *row = [[GrafRow alloc] initGrafRowFromArray:self.array2d andIndex:i];
        [self workWithRow:row];
        [self.Xs addObject:@(i+1)];
        if (i+1 == self.endPointOfSearch) break;
    }
}

/**
 Метод находит open и closed для каждой строчки

 @param row строка из матрицы смежности
 */
- (void) workWithRow:(GrafRow*) row {
    NSMutableArray *temporaryRowArrayOpen = (row.indexOfRow > 0) ? [NSMutableArray arrayWithArray:[self.openArray objectAtIndex:row.indexOfRow-1]] : [NSMutableArray new];
    NSMutableArray *temporaryRowArrayClosed = (row.indexOfRow > 0) ? [NSMutableArray arrayWithArray:[self.closedArray objectAtIndex:row.indexOfRow-1]] : [NSMutableArray new];
    if ([temporaryRowArrayOpen containsObject:@(row.indexOfRow+1)]) {
        [temporaryRowArrayOpen removeObject:@(row.indexOfRow+1)];
    }
    for (NSInteger i = 0; i < row.row.count; i++) {
        BOOL item = [[row.row objectAtIndex:i] boolValue];
        if (item && i != row.indexOfRow) {
            if (![temporaryRowArrayClosed containsObject:@(i+1)] && ![temporaryRowArrayOpen containsObject:@(i+1)]) [temporaryRowArrayOpen addObject:@(i+1)];
        }
    }
    [temporaryRowArrayClosed addObject:@(row.indexOfRow+1)];
    [self.openArray addObject:temporaryRowArrayOpen];
    [self.closedArray addObject:temporaryRowArrayClosed];
}

/**
 Метод начинает обрабатывать всю матрицу смежности для поиска путей из точек в точки
 */
- (void) searchAllPaths {
    NSArray *array1d = [self.array2d objectAtIndex:0];
    for (NSInteger j = 1; j < array1d.count; j++) {
        BOOL item = [[array1d objectAtIndex:j] boolValue];
        if (item) {
            pathTemp = [NSMutableArray arrayWithObjects:@(1), @(j+1), nil];
            [self searchPathInRow:j];
            [self.paths addObject:pathTemp];
        }
    }
}

/**
 Данный метод вызывается рекурсивно, для поиска всех возможных путей по графу

 @param index индекс строки в матрице смежности
 */
- (void) searchPathInRow:(NSInteger) index {
    BOOL isEnd = true;
    NSArray *array1d = [self.array2d objectAtIndex:index];
    for (NSInteger i = index + 1; i < array1d.count; i++) {
        if ([[array1d objectAtIndex:i] boolValue]) {
            isEnd = false;
            [pathTemp addObject:@(i+1)];
            [self searchPathInRow:i];
        }
    }
    if (isEnd) {
        [self.paths addObject:[pathTemp mutableCopy]];
        [pathTemp removeObject:[pathTemp lastObject]];
    }
}

/**
 Метод ищет индекс кратчайшего пути до заданной точки

 @return индекс пути в массиве paths
 */
- (NSInteger) searchShortPathToVertex {
    NSInteger indexPath = -1;
    NSInteger countLast = 0;
    for (NSArray *path in self.paths) {
        if ([path containsObject:@(self.endPointOfSearch)]) {
            if (path.count < countLast || countLast == 0) {
                indexPath = [self.paths indexOfObject:path];
                countLast = path.count;
            }
        }
    }
    return indexPath;
}

- (void) runSearch {
    [self openClosedSearch];
    [self searchAllPaths];
    self.indexOfShortPath = [self searchShortPathToVertex];
}

@end
