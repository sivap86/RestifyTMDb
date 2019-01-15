//
//  SymmetricEncryption.h
//  RestifyTMDb
//
//  Created by siva lingam on 12/1/19.
//  Copyright © 2019 Gemalto (security to be free). All rights reserved.
//

#ifndef SymmetricEncryption_h
#define SymmetricEncryption_h

#include<string.h>
//Secret Symmetric key to encrypt/decrypt the data
const int secretKey = 18;

/** Encrypt the data using secret key
 param : string to be encrypted
 return encrypted string
 since 1.0
 */
char* encryptData(char* data)
{
    
    for(int i = 0; i < strlen(data); i++)
        data[i] -= secretKey;
    return data;
}

/** Decrypt the data using secret key
 param : string to be decrypted
 return decrypted string
 since 1.0
 */
char *decryptData(char* data) {
    for(int i = 0; i < strlen(data); i++)
        data[i] += secretKey;
    return data;
}

#endif /* SymmetricEncryption.h */

