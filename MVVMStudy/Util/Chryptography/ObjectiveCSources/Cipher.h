//
//  Cipher.h
//  TmobWallet
//
//  Created by erenemresamur on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Base64.h"
#import "NSData+Base64.h"
#import "NSData+AES256.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

#define STATIC_CHECKSUM_KEY     @"SKhoAAydSYimCSiK"

@interface Cipher : NSObject

+ (NSString*) doCipher:(NSString*)plainText isEncrypt:(BOOL) isEncrypt key:(NSString*)key;
+ (NSString*) doCipherForAndroidQR:(NSString*)plainText isEncrypt:(BOOL) isEncrypt key:(NSString*)key;
+ (NSString *)hex_sha1:(NSString *)inputString;

+ (unsigned char *)sha1:(NSString *)baseString result:(unsigned char *)result;
+ (NSString *)hexadecimalRepresentation:(unsigned char *)result;
+ (NSString *)b64_sha1:(NSString *)inputString;
+ (NSString *)convertToASCII:(NSString *) sourceStr;

+ (NSString *) Sha512:(NSString *)input;

@end
