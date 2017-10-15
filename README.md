# Graph-IS-Laba-1
Данный проект является первой лабораторной работой по интеллектуальным системам МГТУ "Станкин", написанный на Objective-C языке.

# Disclaimer
This software is published for academic and non-commercial use only.

# Setup
To use the Graf library, copy the Graph and Graph files to your project. The graph is represented as an adjacent matrix [0, 1]. Below is an example of using a library:
```objc
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
graf.type = widthType; //widthType for width search and depthType for depth search.
graf.endPointOfSearch = 7; // end vertex point of search
[graf runSearch]; // this method create open and closed arrays, find all paths array and find index of most shortly past to end point vertex.
```

Copyright (c) 2017 Lutskii Mikhail (http://lwts.ru)
