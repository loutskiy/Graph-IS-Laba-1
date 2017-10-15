//
//  PrintConsole.m
//  Graph IS Laba 1
//
//  Created by Михаил Луцкий on 13.10.2017.
//  Copyright © 2017 LWTS LLC. All rights reserved.
//

#import "PrintConsole.h"

@implementation PrintConsole

+ (void)showOpenClosedTable:(NSArray<GrafTableRow> *)grafTable {
    IFPrint(@"\n|-------|-----|--------|----------|\n|  Шаг  |  X  |  Open  |  Closed  |\n|-------|-----|--------|----------|\n");
    NSInteger i = 0;
    for (GrafTableRow *gtr in grafTable) {
        IFPrint(@"|   %ld   |  %ld  |  %@  |  %@  |\n|-------|-----|--------|----------|\n", i+1, gtr.X, [gtr.open componentsJoinedByString:@","], [gtr.closed componentsJoinedByString:@","]);
        i++;
    }
    IFPrint(@"\n");
}

+ (void)showType:(TypeOfSearch)type {
    IFPrint(@"Тип поиска: ");
    switch (type) {
        case widthType:
            IFPrint(@"в ширину");
            break;
        case depthType:
            IFPrint(@"в глубину");
        default:
            break;
    }
    IFPrint(@"\n\n");
}

+ (void) showShortPath:(NSMutableArray *)path toVertex:(NSInteger)vertex {
    if (path.count > 0) {
        if ([[path lastObject] integerValue] != vertex) {
            BOOL delete = false;
            for (NSInteger i = 0; i < path.count; i++) {
                if (delete) {
                    [path removeObjectAtIndex:i];
                } else {
                    if ([[path objectAtIndex:i] integerValue] == vertex) {
                        delete = true;
                    }
                }
            }
        }
        IFPrint(@"Кратчайший путь из начальной точки в %ld: %@\n\n", vertex, [path componentsJoinedByString:@" -> "]);
    } else {
        IFPrint(@"Путь не существует");
    }
}

/**
 Си-функция, аналог NSLog, но без вывода даты и названия проекта в строке

 @param format формат строка
 @param ... аргументы
 */
void IFPrint (NSString *format, ...) {
    va_list args;
    va_start(args, format);
    
    fputs([[[NSString alloc] initWithFormat:format arguments:args] UTF8String], stdout);
    
    va_end(args);
}

@end
