//
//  Graf.m
//  Graph IS Laba 1
//
//  Created by Михаил Луцкий on 09.10.2017.
//  Copyright © 2017 LWTS LLC. All rights reserved.
//

#import "Graf.h"

@interface Graf () {
    NSMutableArray *pathTemp; // Мутабельный массив временных путей
    BOOL equalsFound;
}

@end

@implementation Graf

- (instancetype)initWithGrafForArray:(NSArray *)array {
    self = [super init];
    if (self) {
        self.array2d = array;
        self.paths = [NSMutableArray new];
        self.grafTable = [NSMutableArray<GrafTableRow> new];
    }
    return self;
}

/**
 Метод запускает обход строк для построения openClosed
 */
- (void) openClosedSearch {
    switch (self.type) {
        case widthType:
            for (NSInteger i = 0; i < self.array2d.count; i++) {
                GrafRow *row = [[GrafRow alloc] initGrafRowFromArray:self.array2d andIndex:i];
                [self workWithRow:row];
                if (i+1 == self.endPointOfSearch) break;
            }
            break;
        case depthType:
            {
                GrafRow *row = [[GrafRow alloc] initGrafRowFromArray:self.array2d andIndex:0];
                [self workWithDepthRow:row];
            }
            break;
    }
}

/**
 Функция для нахождения open/closed при depthType
 Внимание! Функция написано с адским говнокодом. Нужен рефакторинг

 @param row строка из матрицы смежности
 */
- (void) workWithDepthRow:(GrafRow*)row {
    GrafTableRow *lastGtr = [self.grafTable lastObject];
    NSMutableArray *temporaryRowArrayOpen = (row.indexOfRow > 0) ? [NSMutableArray arrayWithArray:lastGtr.open] : [NSMutableArray new];
    NSMutableArray *temporaryRowArrayClosed = (row.indexOfRow > 0) ? [NSMutableArray arrayWithArray:lastGtr.closed] : [NSMutableArray new];
    if ([temporaryRowArrayOpen containsObject:@(row.indexOfRow+1)]) {
        [temporaryRowArrayOpen removeObject:@(row.indexOfRow+1)];
    }
    for (NSInteger i = 0; i < row.row.count; i++) {
        BOOL item = [[row.row objectAtIndex:i] boolValue];
        if (item && i != row.indexOfRow) {
            if (![temporaryRowArrayClosed containsObject:@(i+1)] && ![temporaryRowArrayOpen containsObject:@(i+1)]) [temporaryRowArrayOpen addObject:@(i+1)];
        }
    }
    if (row.indexOfRow == 0) {
        if ([[row.row firstObject] boolValue]) {
            if (![GrafHelper isContainXValue:1 inGrafTable:self.grafTable]) {
                [temporaryRowArrayClosed addObject:@(row.indexOfRow+1)];
                NSLog(@"X %d", 1); // На этом этапе внести иксы, но проверять их на наличие в closed. В случае, если x == self.endPointOfSearch - остановить обход
                GrafTableRow *gtr = [GrafTableRow new];
                gtr.X = 1;
                gtr.closed = temporaryRowArrayClosed;
                gtr.open = temporaryRowArrayOpen;
                [self.grafTable addObject:gtr];
            }
        }
        if (self.endPointOfSearch == 1) return;
    }
    for (NSInteger i = row.indexOfRow + 1; i < row.row.count; i++) {
        if ([[row.row objectAtIndex:i] boolValue]) {
            if (![GrafHelper isContainXValue:i+1 inGrafTable:self.grafTable]) {
                lastGtr = [self.grafTable lastObject];
                temporaryRowArrayOpen = [NSMutableArray arrayWithArray:lastGtr.open];
                if ([temporaryRowArrayOpen containsObject:@(i+1)]) {
                    [temporaryRowArrayOpen removeObject:@(i+1)];
                }
                temporaryRowArrayClosed = [NSMutableArray arrayWithArray:lastGtr.closed];
                NSInteger k = 0;
                for (NSInteger j = i+1; j < row.row.count; j++) {
                    GrafRow *rowS = [[GrafRow alloc] initGrafRowFromArray:self.array2d andIndex:i];
                    if ([[rowS.row objectAtIndex:j] boolValue]){
                        if (![temporaryRowArrayClosed containsObject:@(j+1)] && ![temporaryRowArrayOpen containsObject:@(j+1)]) {
                            [temporaryRowArrayOpen insertObject:@(j+1) atIndex:k];
                            k++;
                        }
                    }
                }
                [temporaryRowArrayClosed addObject:@(i+1)];
                NSLog(@"X %ld", i+1); // На этом этапе внести иксы, но проверять их на наличие в closed. В случае, если x == self.endPointOfSearch - остановить обход
                GrafTableRow *gtr = [GrafTableRow new];
                gtr.X = i+1;
                gtr.closed = temporaryRowArrayClosed;
                gtr.open = temporaryRowArrayOpen;
                [self.grafTable addObject:gtr];
            }
            if (i+1 == self.endPointOfSearch) {
                NSLog(@"совпадение найдено");
                return;};
            GrafRow *row = [[GrafRow alloc] initGrafRowFromArray:self.array2d andIndex:i];
            [self workWithDepthRow:row];
        }
    }
}

/**
 Метод находит open и closed для каждой строчки

 @param row строка из матрицы смежности
 */
- (void) workWithRow:(GrafRow*) row {
    GrafTableRow *lastGtr = [self.grafTable lastObject];
    NSMutableArray *temporaryRowArrayOpen = (row.indexOfRow > 0) ? [NSMutableArray arrayWithArray:lastGtr.open] : [NSMutableArray new];
    NSMutableArray *temporaryRowArrayClosed = (row.indexOfRow > 0) ? [NSMutableArray arrayWithArray:lastGtr.closed] : [NSMutableArray new];
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
    GrafTableRow *gtr = [[GrafTableRow alloc] init];
    gtr.open = temporaryRowArrayOpen;
    gtr.closed = temporaryRowArrayClosed;
    gtr.X = row.indexOfRow+1;
    [self.grafTable addObject:gtr];
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
            if (self.type == widthType) {
                if (path.count < countLast || countLast == 0) {
                    indexPath = [self.paths indexOfObject:path];
                    countLast = path.count;
                }
            } else {
                indexPath = [self.paths indexOfObject:path];
                break;
            }
        }
    }
    return indexPath;
}

- (void) runSearch {
    equalsFound = false;
    [self openClosedSearch];
    [self searchAllPaths];
    self.indexOfShortPath = [self searchShortPathToVertex];
}

@end
