//
//  Encryption.c
//  RestifyTMDb
//
//  Created by siva lingam on 14/1/19.
//  Copyright © 2019 Gemalto (security to be free). All rights reserved.
//

#include "Encryption.h"
#include<string.h>

//Secret Symmetric key to encrypt/decrypt the data
const int secretKey = 18;

char* encryptData(char* data)
{
    for(int i = 0; i < strlen(data); i++)
        data[i] -= secretKey;
    return data;
}

char *decryptData(char* data)
{
    for(int i = 0; i < strlen(data); i++)
        data[i] += secretKey;
    return data;
}
