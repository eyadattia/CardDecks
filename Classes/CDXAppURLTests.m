//
//
// CDXAppURLTests.m
//
//
// Copyright (c) 2009-2014 Arne Harren <ah@0xc0.de>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <XCTest/XCTest.h>
#import "CDXAppURL.h"
#import "CDXCardDeckURLSerializer.h"


@interface CDXAppURLTests : XCTestCase {
    
}

@end


@implementation CDXAppURLTests

- (void)testCardDeckFromURLVersion1 {
    NSString *string = @"carddecks:///add?card%20deck,010203,040506&card%201&card%202";
    CDXCardDeck *deck = [CDXAppURL cardDeckFromURL:[NSURL URLWithString:string]];
    XCTAssertNotNil(deck);
}

- (void)testCardDeckFromURLVersion2 {
    NSString *string = @"carddecks:///2/add?card%20deck,010203,040506&card%201&card%202";
    CDXCardDeck *deck = [CDXAppURL cardDeckFromURL:[NSURL URLWithString:string]];
    XCTAssertNotNil(deck);
}

- (void)testCardDeckFromURLBad {
    NSString *string = @"carddecks:///x/add?card%20deck,010203,040506&card%201&card%202";
    CDXCardDeck *deck = [CDXAppURL cardDeckFromURL:[NSURL URLWithString:string]];
    XCTAssertNil(deck);
}

- (void)testMayBeCardDecksURLStringVersion1 {
    NSString *string = @"carddecks:///add?card%20deck,010203,040506&card%201&card%202";
    XCTAssertTrue([CDXAppURL mayBeCardDecksURLString:string]);
}

- (void)testMayBeCardDecksURLStringVersion2 {
    NSString *string = @"carddecks:///2/add?card%20deck,010203,040506&card%201&card%202";
    XCTAssertTrue([CDXAppURL mayBeCardDecksURLString:string]);
}

- (void)testMayBeCardDecksURLStringBad {
    NSString *string = @"carddecks:///x/add?card%20deck,010203,040506&card%201&card%202";
    XCTAssertFalse([CDXAppURL mayBeCardDecksURLString:string]);
}

- (void)testCarddecksURLStringVersion2 {
    NSString *string = @"card%21deck,g1,d1,c1,id1,is1,it1,r1,s1,ap1&,000000ff,ffffffff,u,0,5";
    CDXCardDeck *deck = [CDXCardDeckURLSerializer cardDeckFromVersion2String:string];
    NSString *urlString = [CDXAppURL carddecksURLStringForVersion2AddActionFromCardDeck:deck];
    XCTAssertEqualObjects(urlString, [@"carddecks:///2/add?" stringByAppendingString:string]);
}

- (void)testHttpURLStringVersion2 {
    NSString *string = @"card%21deck,g1,d1,c1,id1,is1,it1,r1,s1,ap1&,000000ff,ffffffff,u,0,5";
    CDXCardDeck *deck = [CDXCardDeckURLSerializer cardDeckFromVersion2String:string];
    NSString *urlString = [CDXAppURL httpURLStringForVersion2AddActionFromCardDeck:deck];
    XCTAssertEqualObjects(urlString, [@"http://carddecks.protocol.0xc0.de/2/add?" stringByAppendingString:string]);
}

@end

