    //
    //  Encrypter.m
    //  Utils
    //
    //  Created by Murat ADIGÜZEL on 6/1/12.
    //  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
    //

#import "Encrypter.h"
#import "StringCryptor.h"
#import "NSData+Base64.h"

#define _128_BIT_KEY_LENGTH 16

@implementation Encrypter

+(instancetype) sharedCrypter {
    static Encrypter *_sharedCrypter;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedCrypter = [[Encrypter alloc] init];
        
    });
    
    return _sharedCrypter;
}



+ (NSString *)XORValue:(NSString *)value withKey:(NSString *)key {
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    NSInteger keyDataCountToXORValue = valueData.length / keyData.length;
    
    NSMutableData *mutableKeyData = [keyData mutableCopy];
    
    for (int i = 0; i < keyDataCountToXORValue; i++) {
        [mutableKeyData appendData:keyData];
    }
    
    unsigned char* pBytesInput = (unsigned char*)[valueData bytes];
    unsigned char* pBytesKey   = (unsigned char*)[mutableKeyData bytes];
    unsigned char* pResultBytes = (unsigned char*)malloc(valueData.length) ;
    
    
    unsigned char c;
    
    for (int index = 0; index < valueData.length; index++) {
        c = pBytesInput[index] ^ pBytesKey[index];
        pResultBytes[index] = c;
    }
    
    
    NSData *resultData = [NSData dataWithBytes:pResultBytes length:valueData.length];
    NSString *result = [resultData description];
    
    result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@">" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"<" withString:@""];
    NSMutableString* finalResult = [NSMutableString stringWithString:@"Hex+"];
    [finalResult appendString:[key substringWithRange:NSMakeRange(0, 5)]];
    [finalResult appendString:result];
    return finalResult;
}

+ (NSData *)XORValueData:(NSData *)valueData WithKeyData:(NSData *)keyData {
    NSInteger keyDataCountToXORValue = valueData.length / keyData.length;
    NSMutableData *mutableKeyData = [keyData mutableCopy];
    
    for (int i = 0; i < keyDataCountToXORValue; i++) {
        [mutableKeyData appendData:keyData];
    }
    
    unsigned char* pBytesInput = (unsigned char*)[valueData bytes];
    unsigned char* pBytesKey   = (unsigned char*)[mutableKeyData bytes];
    unsigned char* pResultBytes = (unsigned char*)malloc(valueData.length) ;
    
    
    unsigned char c;
    
    for (int index = 0; index < valueData.length; index++) {
        c = pBytesInput[index] ^ pBytesKey[index];
        pResultBytes[index] = c;
    }
    
    NSData *resultData = [NSData dataWithBytes:pResultBytes length:valueData.length];
    return resultData;
}

+ (NSString *)EncryptData:(NSString *)data WithKey:(NSString *)key {
    NSData *keyAsData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *XORedSecretData = [Encrypter XORValueData:[data dataUsingEncoding:NSUTF8StringEncoding] WithKeyData:keyAsData];
    NSString *baseString = [XORedSecretData base64EncodingWithLineLength:0];
    NSData *baseStringData = [baseString dataUsingEncoding:NSUTF8StringEncoding];
    
    CCOptions padding = kCCOptionPKCS7Padding;
    
    keyAsData = [[Encrypter ConvertTo128BitEncryptDecryptKeyFromOriginalKey:key] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *encryptedData = [[StringCryptor sharedCryptor] encrypt:baseStringData key:keyAsData padding:&padding];
    NSString *encryptedString = [encryptedData base64EncodingWithLineLength:0];
    
    return encryptedString;
}

+ (NSString *)DecryptData:(NSString *)data WithKey:(NSString *)key {
    NSData *keyAsData = [[Encrypter ConvertTo128BitEncryptDecryptKeyFromOriginalKey:key] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *decryptedBaseStringData = [NSData dataWithBase64EncodedString:data];
    
    CCOptions padding = kCCOptionPKCS7Padding;
    
    NSData *decryptedData = [[StringCryptor sharedCryptor] decrypt:decryptedBaseStringData key:keyAsData padding:&padding];
    NSString *decryptedResultString = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    NSData *decryptedBaseData = [NSData dataWithBase64EncodedString:decryptedResultString];
    
    keyAsData = [key dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *decryptedXORBaseData = [Encrypter XORValueData:decryptedBaseData WithKeyData:keyAsData];
    
    NSString *decryptedString = [[NSString alloc] initWithData:decryptedXORBaseData encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

+ (NSString *)EncryptAesData:(NSString *)data WithKey:(NSString *)key {
    NSData *keyAsData = [[Encrypter ConvertTo128BitEncryptDecryptKeyFromOriginalKey:key] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *stringData = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    CCOptions padding = kCCOptionPKCS7Padding;
    
    NSData *encryptedData = [[StringCryptor sharedCryptor] encrypt:stringData key:keyAsData padding:&padding];
    NSString *encryptedBase64String = [encryptedData base64Encoding];
    
    return encryptedBase64String;
}

+ (NSString *)DecryptAesData:(NSString *)data WithKey:(NSString *)key {
    NSData *keyAsData = [[Encrypter ConvertTo128BitEncryptDecryptKeyFromOriginalKey:key] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *decryptedBaseStringData = [NSData dataWithBase64EncodedString:data];
    
    CCOptions padding = kCCOptionPKCS7Padding;
    
    NSData *decryptedData = [[StringCryptor sharedCryptor] decrypt:decryptedBaseStringData key:keyAsData padding:&padding];
    NSString *decryptedResultString = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    
    return decryptedResultString;
}

+ (NSString *)ConvertTo128BitEncryptDecryptKeyFromOriginalKey:(NSString *)originalKey {
    if (originalKey.length < _128_BIT_KEY_LENGTH) {
        [NSException raise:@"Key legth exception" format:@"The original key must have at least the size of 16 bytes"];
    }
    
    NSInteger first32BitStartIndex  = originalKey.length - 4;
    int middle32BitStartIndex   = 0;
    NSInteger last64BitStartIndex = (originalKey.length - 7) / 2;
    
    NSString *_128BitKey = [NSString stringWithFormat:@"%@%@%@",
                            [originalKey substringFromIndex:first32BitStartIndex],
                            [originalKey substringToIndex:middle32BitStartIndex + 4],
                            [originalKey substringWithRange:NSMakeRange(last64BitStartIndex, 8)]];
    
    return _128BitKey;
}

+ (NSString *)EncryptString:(NSString *)plainText withShiftCount:(NSInteger)count {
    count %= 8;
    
    NSString *resultText;
    
    if (plainText.length > 0) {
        NSMutableData *myData = [[plainText dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        uint8_t *bytePtr = [myData mutableBytes];
        uint8_t leftmostBits = bytePtr[0] >> (CHAR_BIT - count);
        
        for(int i = 0; i < myData.length - 1; i++) {
            uint8_t left = bytePtr[i + 1] >> (CHAR_BIT - count);
            bytePtr[i] = (bytePtr[i] << count) | left;
            bytePtr[i] ^= 0xFF;
        }
        
        bytePtr[myData.length - 1] = (bytePtr[myData.length - 1] << count) | leftmostBits;
        bytePtr[myData.length - 1] ^= 0xFF;
        
        resultText = [myData base64EncodingWithLineLength:0];
    }
    
    return resultText;
}

+ (NSString *)DecryptString:(NSString *)encryptedText withShiftCount:(NSInteger)count {
    count %= 8;
    
    NSMutableData *myData = [[NSData dataWithBase64EncodedString:encryptedText] mutableCopy];
    
    NSString *resultText;
    
    if (myData.length > 0) {
        uint8_t *bytePtr = [myData mutableBytes];
        uint8_t rightmostBits = bytePtr[myData.length - 1] << (CHAR_BIT - count);
        
        for(int i = (int)myData.length - 1; i > 0; i--) {
            uint8_t left = bytePtr[i - 1] << (CHAR_BIT - count);
            bytePtr[i] = (bytePtr[i] >> count) | left;
            bytePtr[i] ^= 0xFF;
            
        }
        
        bytePtr[0] = (bytePtr[0] >> count) | rightmostBits;
        bytePtr[0] ^= 0xFF;
        resultText = [[NSString alloc] initWithData:[NSData dataWithBytes:bytePtr length:myData.length] encoding:NSUTF8StringEncoding];
    }
    
    return resultText;
}

+ (NSString*) doCipher:(NSString*)plainText isEncrypt:(BOOL) isEncrypt key:(NSString*)key{
    CCOperation encryptOrDecrypt = isEncrypt ? kCCEncrypt : kCCDecrypt;
    
    if (encryptOrDecrypt == kCCDecrypt){
        NSData *decryptedData = [Encrypter AES256Decrypt:[NSData dataWithBase64EncodedString:plainText] withKey:key];
        NSString *decryptedString = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
        return decryptedString;
        
    } else{
        NSData *encryptedData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        NSString *encryptedString=  [[Encrypter AES256Encrypt:encryptedData withKey:key] base64Encoding];
        return encryptedString;
    }
}

+(NSData *)AES256Encrypt:(NSData *)data withKey:(NSString *)key {
    key = [Encrypter ConvertTo128BitEncryptDecryptKeyFromOriginalKey:key];
        // 'key' should be 32 bytes for AES128, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
        // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
        //See the doc: For block ciphers, the output size will always be less than or
        //equal to the input size plus the size of one block.
        //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    NSData *input= [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          [input bytes] /* initialization vector (optional) */,
                                          [data bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
            //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

+(NSData *)AES256Decrypt:(NSData *)data withKey:(NSString *)key {
    key = [Encrypter ConvertTo128BitEncryptDecryptKeyFromOriginalKey:key];
        // 'key' should be 32 bytes for AES128, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
        // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
        //See the doc: For block ciphers, the output size will always be less than or
        //equal to the input size plus the size of one block.
        //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    NSData *input= [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES128,
                                          [input bytes]  /* initialization vector (optional) */,
                                          [data bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
            //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

+ (NSData *)encryptDES:(NSData *)data withKey:(NSData *)key
{
    size_t numBytesEncrypted = 0;
    size_t bufferSize = data.length + kCCBlockSizeDES;
    void *buffer = malloc(bufferSize);
    
    CCCryptorStatus result = CCCrypt( kCCEncrypt, kCCAlgorithmDES, kCCOptionPKCS7Padding,
                                     key.bytes, kCCKeySizeDES,
                                     NULL,
                                     data.bytes, data.length,
                                     buffer, bufferSize,
                                     &numBytesEncrypted);
    NSData *output = [NSData dataWithBytes:buffer length:numBytesEncrypted];
    free(buffer);
    if( result == kCCSuccess )
    {
        return output;
    } else {
        NSLog(@"Failed DES encrypt...");
        return nil;
    }
}

+ (NSData *) decryptDES:(NSData *)data withKey:(NSData *)key
{
    size_t numBytesEncrypted = 0;
    
    size_t bufferSize = data.length + kCCBlockSizeDES;
    void *buffer_decrypt = malloc(bufferSize);
    CCCryptorStatus result = CCCrypt( kCCDecrypt , kCCAlgorithmDES, kCCOptionPKCS7Padding,
                                     key.bytes, kCCKeySizeDES,
                                     NULL,
                                     data.bytes, data.length,
                                     buffer_decrypt, bufferSize,
                                     &numBytesEncrypted );
    
    NSData *output = [NSData dataWithBytes:buffer_decrypt length:numBytesEncrypted];
    free(buffer_decrypt);
    if( result == kCCSuccess )
    {
        return output;
    } else {
        NSLog(@"Failed DES decrypt ...");
        return nil;
    }
}

+ (NSString *)ConvertToBase64:(NSString *)data {
	unsigned char digest[CC_SHA1_DIGEST_LENGTH];
	NSData *stringBytes = [data dataUsingEncoding: NSISOLatin2StringEncoding]; 

	if (CC_SHA1([stringBytes bytes], (CC_LONG)[stringBytes length], digest)) {
		NSData *strData = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
		NSString *base64String = [strData base64Encoding];
		return base64String;
	}

	return @"";
}

@end
