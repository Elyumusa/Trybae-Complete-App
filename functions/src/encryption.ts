//import * as functions from "firebase-functions";

//import * as cors from "cors";
//const corsHandler = cors({ origin: true });
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


const crypto = require('crypto');

 class Encryption{
    IVKey: any;
    secretKey: any;
    algorithm: any;
    constructor(ivKey: any, secretkey: any, algo: any) {
        this.IVKey = ivKey;
        this.secretKey = secretkey;
        this.algorithm = algo;
    }

    encrypt(payload: any){
        let secret = crypto
            .createHash('sha256')
            .update(this.secretKey)
            .digest('hex')
            .substring(0, 32);

        secret = Buffer.from(secret);

        // prepare the IV key
        let IV = crypto
            .createHash('sha256')
            .update(this.IVKey)
            .digest('hex')
            .substring(0, 16);

        IV = Buffer.from(IV);

        const cipher = crypto
            .createCipheriv(this.algorithm, secret, IV);

        const result = Buffer
            .concat([cipher.update(payload), cipher.final()]);

        return Buffer.from(result).toString('base64');
    }
}
module.exports = Encryption
export {Encryption}



