//
//  Encrypter.h
//  Utils
//
//  Created by Murat ADIGÜZEL on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encrypter : NSObject

+ (NSString *)EncryptData:(NSString *)data WithKey:(NSString *)key;
+ (NSString *)DecryptData:(NSString *)data WithKey:(NSString *)key;
+ (NSString *)EncryptAesData:(NSString *)data WithKey:(NSString *)key;
+ (NSString *)DecryptAesData:(NSString *)data WithKey:(NSString *)key;
+ (NSString *)EncryptString:(NSString *)plaintText withShiftCount:(NSInteger)count;
+ (NSString *)DecryptString:(NSString *)encryptedText withShiftCount:(NSInteger)count;
+ (NSString *)doCipher:(NSString*)plainText isEncrypt:(BOOL) isEncrypt key:(NSString*)key;
+ (NSString *)XORValue:(NSString *)value withKey:(NSString *)key;
+ (NSString *)ConvertToBase64:(NSString *)data;
+(instancetype) sharedCrypter;

@property (nonatomic) NSString *ChecksumKey;

@end
