//
//  main.m
//  Graph IS Laba 1
//
//  Created by Михаил Луцкий on 09.10.2017.
//  Copyright © 2017 LWTS LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Graf.h"
#import "PrintConsole.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *grafData = @[
                              //  1     2     3     4     5     6     7    ///
                              @[@(1), @(1), @(1), @(1), @(0), @(0), @(0)], //1
                              @[@(1), @(1), @(0), @(0), @(1), @(1), @(0)], //2
                              @[@(1), @(0), @(1), @(0), @(0), @(0), @(1)], //3
                              @[@(1), @(0), @(0), @(1), @(0), @(0), @(0)], //4
                              @[@(0), @(1), @(0), @(0), @(1), @(0), @(0)], //5
                              @[@(0), @(1), @(0), @(0), @(0), @(1), @(1)], //6
                              @[@(0), @(0), @(1), @(0), @(0), @(1), @(1)], //7
                              ];
        Graf *graf = [[Graf alloc] initWithGrafForArray:grafData];
        graf.type = depthType;
        graf.endPointOfSearch = 7;
        [graf runSearch];
        [PrintConsole showType:graf.type];
        [PrintConsole showOpenClosedTable:graf.grafTable];
        @try {
            [PrintConsole showShortPath:[graf.paths objectAtIndex:graf.indexOfShortPath] toVertex:graf.endPointOfSearch];
        } @catch (NSException *exc) {
            NSLog(@"Vertex don't exist. Exit with exc: %@", exc);
        }
    }
    return 0;
}
