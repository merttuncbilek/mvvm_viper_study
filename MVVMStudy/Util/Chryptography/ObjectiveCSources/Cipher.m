//
//  Cipher.m
//  TmobWallet
//
//  Created by erenemresamur on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "NSData+CommonCrypto.h"
#import "Cipher.h"

@implementation Cipher

+ (NSString*) doCipher:(NSString*)plainText isEncrypt:(BOOL) isEncrypt key:(NSString*)key{

    CCOperation encryptOrDecrypt = isEncrypt ? kCCEncrypt : kCCDecrypt;
    
    if (encryptOrDecrypt == kCCDecrypt){
      
        
        NSData *decryptedData = [[Base64 decode:plainText] AES256DecryptWithKey:key];
        NSString *decryptedString = [[NSString alloc]initWithData:decryptedData encoding:NSUTF8StringEncoding];

        return decryptedString;
    }else{
        NSData *encryptedData =[plainText dataUsingEncoding:NSUTF8StringEncoding];
        
        NSString *encryptedString= [Base64 encode:[encryptedData AES256EncryptWithKey:key]];
        return encryptedString;
    }
}

+ (NSString*) doCipherForAndroidQR:(NSString*)plainText isEncrypt:(BOOL) isEncrypt key:(NSString*)key{
    
    const void *vplainText;
    
    size_t plainTextBufferSize;
    
    
    CCOperation encryptOrDecrypt = isEncrypt ? kCCEncrypt : kCCDecrypt;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        
        NSData *EncryptData = [[NSData alloc] initWithBase64EncodedString:plainText];
        
        plainTextBufferSize = [EncryptData length];
        
        vplainText = [EncryptData bytes];
    }
    else
    {
        plainText = [NSString stringWithFormat:@"%@",plainText];
        
        plainText = [plainText stringByReplacingOccurrencesOfString:@"Ç" withString:@"C"];
        plainText = [plainText stringByReplacingOccurrencesOfString:@"Ğ" withString:@"G"];
        plainText = [plainText stringByReplacingOccurrencesOfString:@"İ" withString:@"I"];
        plainText = [plainText stringByReplacingOccurrencesOfString:@"Ö" withString:@"O"];
        plainText = [plainText stringByReplacingOccurrencesOfString:@"Ş" withString:@"S"];
        plainText = [plainText stringByReplacingOccurrencesOfString:@"Ü" withString:@"U"];
        plainText = [plainText stringByReplacingOccurrencesOfString:@"ç" withString:@"c"];
        plainText = [plainText stringByReplacingOccurrencesOfString:@"Ğ" withString:@"g"];
        plainText = [plainText stringByReplacingOccurrencesOfString:@"ı" withString:@"i"];
        plainText = [plainText stringByReplacingOccurrencesOfString:@"ö" withString:@"o"];
        plainText = [plainText stringByReplacingOccurrencesOfString:@"ü" withString:@"u"];
        plainText = [plainText stringByReplacingOccurrencesOfString:@"ş" withString:@"s"];

        plainTextBufferSize = [plainText length];
        
        vplainText = (const void *) [plainText UTF8String];
        
        
    }
    
    CCCryptorStatus ccStatus;
    
    uint8_t *bufferPtr = NULL;
    
    size_t bufferPtrSize = 0;
    
    size_t movedBytes = 0;
    
    // uint8_t iv[kCCBlockSize3DES];
    
    uint8_t iv[kCCBlockSize3DES];
    
    memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    
    const void *vkey = (const void *) [key UTF8String];
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       
                       kCCAlgorithm3DES,
                       
                       kCCOptionPKCS7Padding,
                       
                       vkey, //"123456789012345678901234", //key
                       
                       kCCKeySize3DES,
                       
                       iv, //"init Vec", //iv,
                       
                       vplainText, //"Your Name", //plainText,
                       
                       plainTextBufferSize,
                       
                       (void *)bufferPtr,
                       
                       bufferPtrSize,
                       
                       &movedBytes);
    
    
    if (ccStatus == kCCSuccess)
        ;
    
    else if (ccStatus == kCCParamError) return @"PARAM ERROR";
    
    else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
    
    else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
    
    else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
    
    else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
    
    else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED";
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt) {
        result = [[NSString alloc] initWithData: [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSASCIIStringEncoding];
    } else {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        
        result = [myData base64Encoding];
    }
    
    return result;
}


+ (NSString *)hex_sha1:(NSString *)inputString {

    unsigned char result[CC_SHA1_DIGEST_LENGTH+1];
    [self sha1:inputString result:result];
    return [self hexadecimalRepresentation:result];
}

+ (unsigned char *)sha1:(NSString *)baseString result:(unsigned char *)result {
    char *c_baseString=(char *)[baseString UTF8String];
    
    CC_SHA1(c_baseString, (CC_LONG)strlen(c_baseString), result);
    return result;
}

+ (NSString *)hexadecimalRepresentation:(unsigned char *)result {
    NSString *password=[[NSString alloc] init];
    for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        password=[password stringByAppendingFormat:@"%02x", result[i]];
    }
    return password;
}

+ (NSString *) Sha512:(NSString *)input{
    
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}


+ (NSString *)b64_sha1:(NSString *)inputString {
    unsigned char result[CC_SHA1_DIGEST_LENGTH+1];
    [self sha1:inputString result:result];
    
    //    return [self base64:result];
    
    [Base64 initialize];
    return [Base64 encode:result length:CC_SHA1_DIGEST_LENGTH];
    
}

+ (NSString *) convertToASCII:(NSString *) sourceStr{
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString:@"Ş" withString:@"?"];
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString:@"ş" withString:@"?"];
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString:@"Ç" withString:@"?"];
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString:@"ç" withString:@"?"];
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString:@"Ö" withString:@"?"];
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString:@"ö" withString:@"?"];
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString:@"Ğ" withString:@"?"];
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString:@"ğ" withString:@"?"];
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString:@"İ" withString:@"?"];
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString:@"ı" withString:@"?"];
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString:@"Ü" withString:@"?"];
    sourceStr = [sourceStr stringByReplacingOccurrencesOfString:@"ü" withString:@"?"];
    
    return sourceStr;
}


@end
