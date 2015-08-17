//
//  BONIndentSpacerTestCase.m
//  BonMot
//
//  Created by Zev Eisenberg on 8/15/15.
//  Copyright (c) 2015 Zev Eisenberg. All rights reserved.
//

#import "BONBaseTestCase.h"

#import <BonMot/BonMot.h>

@interface BONIndentSpacerTestCase : BONBaseTestCase

@end

@implementation BONIndentSpacerTestCase

- (void)testIndentingWithImages
{
    NSString *quote = [NSString stringWithFormat:@"“It’s OK to ask for help. When doing a final exam, all the work must be yours, but in engineering, the point is to get the job done, and people are happy to help. Corollaries: You should be generous with credit, and you should be happy to help others.”%@%@Radia Perlman.", BONSpecial.lineSeparator, BONSpecial.emDash];
    UIImage *image = [UIImage imageNamed:@"robot" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    BONChain *firstBaseTextChain = BONChain.new.fontNameAndSize(@"AvenirNextCondensed-Medium", 18.0f);
    BONChain *imageChain = firstBaseTextChain.image(image).indentSpacer(4.0f).baselineOffset(-6.0f);

    imageChain.append(firstBaseTextChain.string(quote));

    NSAttributedString *attributedString = imageChain.attributedString;

    NSString *controlString = [NSString stringWithFormat:@"%@\t“It’s OK to ask for help. When doing a final exam, all the work must be yours, but in engineering, the point is to get the job done, and people are happy to help. Corollaries: You should be generous with credit, and you should be happy to help others.”%@%@Radia Perlman.", BONSpecial.objectReplacementCharacter, BONSpecial.lineSeparator, BONSpecial.emDash];
    XCTAssertEqualObjects(attributedString.string, controlString);
}

- (void)testIndentingWithText
{
    NSString *secondQuote = @"You can also use strings (including emoji) for bullets as well, and they will still properly indent the appended text by the right amount.";
    BONChain *secondBaseTextChain = BONChain.new.fontNameAndSize(@"AvenirNextCondensed-Regular", 18.0f);
    BONChain *secondChain = secondBaseTextChain.string(@"🍑 →").indentSpacer(4.0f).textColor([UIColor orangeColor]);
    secondChain.append(secondBaseTextChain.string(secondQuote).textColor([UIColor darkGrayColor]));

    NSAttributedString *attributedString = secondChain.attributedString;

    XCTAssertEqualObjects(attributedString.string, @"🍑 →\tYou can also use strings (including emoji) for bullets as well, and they will still properly indent the appended text by the right amount.");
}

@end
