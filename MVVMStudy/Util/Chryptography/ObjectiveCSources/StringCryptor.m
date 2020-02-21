//
//  StringEncryption.m
//
//  Created by DAVID VEKSLER on 2/4/09.
//

#import "StringCryptor.h"
#import "NSData+Base64.h"

unsigned char obfuscatedSecretKey[] = { 0x52, 0x32, 0xe9, 0x6d, 0x94, 0x89, 0xc5, 0x56, 0x6a, 0xfd, 0x5f, 0xcf, 0x38, 0xe4, 0x62, 0x21};
unsigned char actualSecretKey[sizeof(obfuscatedSecretKey)];

@implementation StringCryptor

+ (instancetype)sharedCryptor {
    static StringCryptor *sharedMyCryptor = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyCryptor = [[self alloc] init];
        
        unsigned char obfuscator[CC_SHA1_DIGEST_LENGTH];
        NSString *classNames = [NSString stringWithFormat:@"%@%@", NSStringFromClass(NSIndexSet.class), NSStringFromClass(NSFileCoordinator.class)];
        NSData *className = [classNames dataUsingEncoding:NSUTF8StringEncoding];
        CC_SHA1(className.bytes, (CC_LONG)className.length, obfuscator);
        
        for (int i = 0; i < sizeof(obfuscatedSecretKey); i++) {
            actualSecretKey[i] = obfuscatedSecretKey[i] ^ obfuscator[i];
        }
    });
    
    return sharedMyCryptor;
}

- (NSString *)encryptString:(NSString *)string {
    NSData *keyAsData = [NSData dataWithBytes:actualSecretKey length:sizeof(actualSecretKey)];
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    CCOptions padding = kCCOptionPKCS7Padding;
    NSData *encryptedStringData = [self encrypt:stringData key:keyAsData padding:&padding];
    
    return [encryptedStringData base64Encoding];
}

- (NSString *)decryptString:(NSString *)string {
    NSData *keyAsData = [NSData dataWithBytes:actualSecretKey length:sizeof(actualSecretKey)];
    NSData *decryptedBaseStringData = [NSData dataWithBase64EncodedString:string];
    CCOptions padding = kCCOptionPKCS7Padding;
    NSData *decryptedData = [self decrypt:decryptedBaseStringData key:keyAsData padding:&padding];
    NSString *decryptedResultString = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    
    return decryptedResultString;
}

- (NSData *)encrypt:(NSData *)plainText key:(NSData *)aSymmetricKey padding:(CCOptions *)pkcs7 {
    return [self doCipher:plainText key:aSymmetricKey context:kCCEncrypt padding:pkcs7];
}

- (NSData *)decrypt:(NSData *)plainText key:(NSData *)aSymmetricKey padding:(CCOptions *)pkcs7 {
    return [self doCipher:plainText key:aSymmetricKey context:kCCDecrypt padding:pkcs7];
}

- (NSData *)doCipher:(NSData *)plainText key:(NSData *)aSymmetricKey context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7 {
    CCCryptorStatus ccStatus = kCCSuccess;
    // Symmetric crypto reference.
    CCCryptorRef thisEncipher = NULL;
    // Cipher Text container.
    NSData * cipherOrPlainText = nil;
    // Pointer to output buffer.
    uint8_t * bufferPtr = NULL;
    // Total size of the buffer.
    size_t bufferPtrSize = 0;
    // Remaining bytes to be performed on.
    size_t remainingBytes = 0;
    // Number of bytes moved to buffer.
    size_t movedBytes = 0;
    // Length of plainText buffer.
    size_t plainTextBufferSize = 0;
    // Placeholder for total written.
    size_t totalBytesWritten = 0;
    // A friendly helper pointer.
    uint8_t * ptr;
	
    // Initialization vector; dummy in this case 0's.
    uint8_t iv[kChosenCipherBlockSize];
    memset((void *) iv, 0x0, (size_t) sizeof(iv));

    plainTextBufferSize = [plainText length];
	
    //LOGGING_FACILITY(plainTextBufferSize > 0, @"Empty plaintext passed in." );
	
    // We don't want to toss padding on if we don't need to
    if(encryptOrDecrypt == kCCEncrypt) {
        if(*pkcs7 != kCCOptionECBMode) {
            *pkcs7 = kCCOptionPKCS7Padding;
        }
    } else if(encryptOrDecrypt != kCCDecrypt) {
        NSLog(@"Invalid CCOperation parameter [%d] for cipher context.", *pkcs7 );
    } 
	
    // Create and Initialize the crypto reference.
    ccStatus = CCCryptorCreate(encryptOrDecrypt,
                               kCCAlgorithmAES128,
                               *pkcs7,
                               (const void *)[aSymmetricKey bytes],
                               kChosenCipherKeySize,
                               (const void *)iv,
                               &thisEncipher
                               );
	
    // Calculate byte block alignment for all calls through to and including final.
    bufferPtrSize = CCCryptorGetOutputLength(thisEncipher, plainTextBufferSize, true);
	
    // Allocate buffer.
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t) );
	
    // Zero out buffer.
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
	
    // Initialize some necessary book keeping.
	
    ptr = bufferPtr;
	
    // Set up initial size.
    remainingBytes = bufferPtrSize;
	
    // Actually perform the encryption or decryption.
    ccStatus = CCCryptorUpdate(thisEncipher,
                               (const void *) [plainText bytes],
                               plainTextBufferSize,
                               ptr,
                               remainingBytes,
                               &movedBytes
                               );
	
    // Handle book keeping.
    ptr += movedBytes;
    remainingBytes -= movedBytes;
    totalBytesWritten += movedBytes;
	
    // Finalize everything to the output buffer.
    ccStatus = CCCryptorFinal(thisEncipher,
                              ptr,
                              remainingBytes,
                              &movedBytes
                              );
	
    totalBytesWritten += movedBytes;
	
    if(thisEncipher) {
        (void) CCCryptorRelease(thisEncipher);
        thisEncipher = NULL;
    }
	
    if (ccStatus == kCCSuccess)
        cipherOrPlainText = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)totalBytesWritten];
    else
        cipherOrPlainText = nil;
	
    if(bufferPtr) free(bufferPtr);
	
    return cipherOrPlainText;
}

@end
