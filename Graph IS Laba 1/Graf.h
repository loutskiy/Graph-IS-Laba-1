//
//  Graf.h
//  Graph IS Laba 1
//
//  Created by Михаил Луцкий on 09.10.2017.
//  Copyright © 2017 LWTS LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Определение типа TypeOfSearch для создания треггера по вариантам поиска

 - widthType: Поиск в ширину
 - depthType: Поиск в глубину
 */
typedef NS_ENUM(NSInteger,TypeOfSearch) {
    widthType = 1,
    depthType
};

/**
 Класс для работы с графом
 */
@interface Graf : NSObject

/**
 Инициализатор графа по таблице смежности

 @param array таблица смежности
 @return экземпляр объекта
 */
- (instancetype)initWithGrafForArray:(NSArray *)array;

/**
 Метод вызывает работу всех сабметодов в нужной последовательности. Вызывать, после установки всех параметров.
 */
- (void) runSearch;

/**
 Матрица смежности
 */
@property (nonatomic) NSArray *array2d;

/**
 Вершина поиска
 */
@property (nonatomic) NSInteger endPointOfSearch;

/**
 Тип обхода
 */
@property (nonatomic) TypeOfSearch type;

/**
 Open массив (мутабельный)
 */
@property (nonatomic) NSMutableArray *openArray;

/**
 Closed массив (мутабельный)
 */
@property (nonatomic) NSMutableArray *closedArray;

/**
 Массив всех возможных путей до любой точки графа
 */
@property (nonatomic) NSMutableArray *paths;

/**
 Индекс короткого пути из массива self.paths
 */
@property (nonatomic) NSInteger indexOfShortPath;

/**
 Мутабельный массив всех иксов
 */
@property (nonatomic) NSMutableArray *Xs;

@end
