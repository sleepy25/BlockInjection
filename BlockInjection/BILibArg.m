//
//  BILibArg.m
//
//  Created by ToKoRo on 2013-03-06.
//

#import "BILibArg.h"
#import "BILibDummyStruct.h"

#define ELSE_BILIBARG(siz)                                                         \
    }                                                                              \
    else if (siz >= size) {                                                        \
        struct bilib_struct_##siz arg = va_arg(*pargp, struct bilib_struct_##siz); \
    [invocation setArgument:&arg atIndex:index]

#define EXPAND_ELSE_BILIBAG(prf) \
    ELSE_BILIBARG(prf##00);      \
    ELSE_BILIBARG(prf##04);      \
    ELSE_BILIBARG(prf##08);      \
    ELSE_BILIBARG(prf##12);      \
    ELSE_BILIBARG(prf##16);      \
    ELSE_BILIBARG(prf##20);      \
    ELSE_BILIBARG(prf##24);      \
    ELSE_BILIBARG(prf##28);      \
    ELSE_BILIBARG(prf##32);      \
    ELSE_BILIBARG(prf##36);      \
    ELSE_BILIBARG(prf##40);      \
    ELSE_BILIBARG(prf##44);      \
    ELSE_BILIBARG(prf##48);      \
    ELSE_BILIBARG(prf##52);      \
    ELSE_BILIBARG(prf##56);      \
    ELSE_BILIBARG(prf##60);      \
    ELSE_BILIBARG(prf##64);      \
    ELSE_BILIBARG(prf##68);      \
    ELSE_BILIBARG(prf##72);      \
    ELSE_BILIBARG(prf##76);      \
    ELSE_BILIBARG(prf##80);      \
    ELSE_BILIBARG(prf##84);      \
    ELSE_BILIBARG(prf##88);      \
    ELSE_BILIBARG(prf##92);      \
    ELSE_BILIBARG(prf##96)

@implementation BILibArg

#pragma mark - Public Interface

+ (void)sendArgumentsToInvocation:(NSInvocation *)invocation
                        arguments:(va_list *)pargp
                numberOfArguments:(NSUInteger)numberOfArguments
                        //                        signature:(NSMethodSignature*)signature
                        //{
                        //  NSArray* objectTypeEncoding = @[
                        //                                  @"@",
                        //                                  @"#",
                        //                                  @"*",
                        //                                  @"^",
                        //                                  @":"
                        //                                  ];
                        //  NSArray* smallPrimitiveTypeEncoding = @[
                        //                                    @"c",
                        //                                    @"i",
                        //                                    @"s",
                        //                                    @"l",
                        //                                    @"C",
                        //                                    @"I",
                        //                                    @"S",
                        //                                    @"L",
                        //                                    @"f",
                        //                                    @"B",
                        //                                    ];
                        //
                        //  int index = 2;
                        //  while (numberOfArguments--) {
                        //    NSUInteger size, alignment;
                        //    const char *type = [signature getArgumentTypeAtIndex:index];
                        //    NSGetSizeAndAlignment(type, &size, &alignment);
                        //    NSString* typeString = [NSString stringWithUTF8String:type];
                        //    if ([objectTypeEncoding containsObject:typeString]){
                        //      // object type pointer
                        //      void * pval = va_arg(*pargp, void*);
                        //      [invocation setArgument:&pval atIndex:index++];
                        //    } else if ([smallPrimitiveTypeEncoding containsObject:typeString]) {
                        //      int32_t val = va_arg(*pargp, int32_t);
                        //      [invocation setArgument:&val atIndex:index++];
                        //    } else if ([typeString isEqualToString:@"q"] || [typeString isEqualToString:@"Q"]) {
                        //      long long val = va_arg(*pargp, long long);
                        //      [invocation setArgument:&val atIndex:index++];
                        //    } else if ([typeString isEqualToString:@"d"]) {
                        //      double val = va_arg(*pargp, double);
                        //      [invocation setArgument:&val atIndex:index++];
                        //    } else {
                        //      // others, primitive types or structure, array
                        //      if (4 >= size) size = 4;
                        //      if (size % alignment != 0) size = (size / alignment) * (alignment + 1);
                        //      [BILibArg sendOneArgumentToInvocation:invocation
                        //                                  arguments:pargp
                        //                                      index:index++
                        //                                       size:size];

                        //                        signature:(NSMethodSignature*)signature
                        //{
                        //  int index = 2;
                        //  while (numberOfArguments--) {
                        //    NSUInteger size, alignment;
                        //    const char *type = [signature getArgumentTypeAtIndex:index];
                        //    NSString* typeString = [NSString stringWithUTF8String:type];
                        //    if ([typeString isEqualToString:@"@"] ||
                        //        [typeString isEqualToString:@"#"] ||
                        //        [typeString isEqualToString:@"*"] ||
                        //        [typeString rangeOfString:@"^"].location != NSNotFound ||
                        //        [typeString isEqualToString:@":"] ){
                        //      // object type pointer
                        //      void * pval = va_arg(*pargp, void*);
                        //      [invocation setArgument:&pval atIndex:index++];
                        //    } else {
                        //      // others, primitive types or structure, array
                        //      NSGetSizeAndAlignment(type, &size, &alignment);
                        //      [BILibArg sendOneArgumentToInvocation:invocation
                        //                                  arguments:pargp
                        //                                      index:index++
                        //                                       size:size];

                        signature:(NSMethodSignature *)signature {
    int index = 2;
    while (numberOfArguments--) {
        NSUInteger size, alignment;
        const char *type = [signature getArgumentTypeAtIndex:index];
#warning Fix / Set proper arguments handling
        NSGetSizeAndAlignment(type, &size, &alignment);

        NSLog(@"Arg Type : %s, Size : %li Aligment: %li", type, size, alignment);
        if (type[0] == '@') {
            void *pval = va_arg(*pargp, void *);
            [invocation setArgument:&pval atIndex:index++];
        } else if (type[0] == 'q') {
            long pval = va_arg(*pargp, long);
            [invocation setArgument:&pval atIndex:index++];
        } else if (4 >= size) {
            void *pval = va_arg(*pargp, void *);
            [invocation setArgument:&pval atIndex:index++];
        } else if (8 >= size) {
            double dval = va_arg(*pargp, double);
            [invocation setArgument:&dval atIndex:index++];
        } else {
            [BILibArg sendOneArgumentToInvocation:invocation
                                        arguments:pargp
                                            index:index++
                                             size:size];
        }
    }
}

#pragma mark - Private Methods

+ (void)sendOneArgumentToInvocation:(NSInvocation *)invocation
                          arguments:(va_list *)pargp
                              index:(NSUInteger)index
                               size:(NSUInteger)size {
    if (NO) {
        ELSE_BILIBARG(4);
        ELSE_BILIBARG(8);
        ELSE_BILIBARG(12);
        ELSE_BILIBARG(16);
        ELSE_BILIBARG(20);
        ELSE_BILIBARG(24);
        ELSE_BILIBARG(28);
        ELSE_BILIBARG(32);
        ELSE_BILIBARG(36);
        ELSE_BILIBARG(40);
        ELSE_BILIBARG(44);
        ELSE_BILIBARG(48);
        ELSE_BILIBARG(52);
        ELSE_BILIBARG(56);
        ELSE_BILIBARG(60);
        ELSE_BILIBARG(64);
        ELSE_BILIBARG(68);
        ELSE_BILIBARG(72);
        ELSE_BILIBARG(76);
        ELSE_BILIBARG(80);
        ELSE_BILIBARG(84);
        ELSE_BILIBARG(88);
        ELSE_BILIBARG(92);
        ELSE_BILIBARG(96);
        EXPAND_ELSE_BILIBAG(1);
        EXPAND_ELSE_BILIBAG(2);
        EXPAND_ELSE_BILIBAG(3);
        EXPAND_ELSE_BILIBAG(4);
        EXPAND_ELSE_BILIBAG(5);
        EXPAND_ELSE_BILIBAG(6);
        EXPAND_ELSE_BILIBAG(7);
        EXPAND_ELSE_BILIBAG(8);
        EXPAND_ELSE_BILIBAG(9);
        EXPAND_ELSE_BILIBAG(10);
    } else {
        struct bilib_struct_1096 arg = va_arg(*pargp, struct bilib_struct_1096);
        [invocation setArgument:&arg atIndex:index];
    }
}

@end
