//
//  StringEncryption.h
//
//  Created by DAVID VEKSLER on 2/4/09.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#define kChosenCipherBlockSize	kCCBlockSizeAES128
#define kChosenCipherKeySize	kCCKeySizeAES128
#define kChosenDigestLength		CC_SHA1_DIGEST_LENGTH

@interface StringCryptor : NSObject

+ (instancetype)sharedCryptor;
- (NSString *)encryptString:(NSString *)string;
- (NSString *)decryptString:(NSString *)string;
- (NSData *)encrypt:(NSData *)plainText key:(NSData *)aSymmetricKey padding:(CCOptions *)pkcs7;
- (NSData *)decrypt:(NSData *)plainText key:(NSData *)aSymmetricKey padding:(CCOptions *)pkcs7;
- (NSData *)doCipher:(NSData *)plainText key:(NSData *)aSymmetricKey context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7;

@end
