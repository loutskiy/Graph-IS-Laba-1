//
//  PrintConsole.m
//  Graph IS Laba 1
//
//  Created by Михаил Луцкий on 13.10.2017.
//  Copyright © 2017 LWTS LLC. All rights reserved.
//

#import "PrintConsole.h"

@implementation PrintConsole

+ (void)showOpen:(NSArray *)open andClosedArray:(NSArray *)closed withXs:(NSArray *)Xs {
    if (open.count == closed.count && open.count == Xs.count) {
        IFPrint(@"\n|-------|-----|--------|----------|\n|  Шаг  |  X  |  Open  |  Closed  |\n|-------|-----|--------|----------|\n");
        for (NSInteger i = 0; i < open.count; i++) {
            IFPrint(@"|   %ld   |  %@  |  %@  |  %@  |\n|-------|-----|--------|----------|\n", i+1, [Xs objectAtIndex:i], [[open objectAtIndex:i] componentsJoinedByString:@","], [[closed objectAtIndex:i] componentsJoinedByString:@","]);
        }
        IFPrint(@"\n");
    } else {
        IFPrint(@"/**************/\nERROR COUNTS\n");
    }
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
