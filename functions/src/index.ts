import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as cors from "cors";
const crypto = require('crypto');
//import {Encryption} from './encryption';
const corsHandler = cors({ origin: true });
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
admin.initializeApp({
    credential: admin.credential.applicationDefault(),
});
const db = admin.firestore();
const fcm = admin.messaging();



export const test=functions.https.onCall((data, context) => {
    const payload: admin.messaging.MessagingPayload = {
        notification: {
            title: `Order asdfasdf`,
            body: `The order asdfasdf with total of  asdfasdf has been successfully placed, you will get notifications of order updates`,
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
        
    };
    console.log('Very good the function is ');
    return fcm.sendToDevice('f846gPYPRoGyYts3K4mw3b:APA91bEStNBudd6w7jel8MYiLjwhH0orV9n5vmrVpd2rzGBCRsj2zXulJjY831fbfQ4EY02xvF5ghEM929kSg2GrRcj6Z_zJ4v7l--F7HQfDKC35sqN7_wurZ6UGALwdOKzq6n_g4XZL', payload);
  });
/*export const tinggPay=functions.https.onRequest((req,res)=>{
    console.log(req.method)
   
            const access_key = "$2a$08$w2ZCHCTUBLoQQSM.OdgfYeVjIB0jWO5E3lT16SXMZG/FhwOgw7a5y"
    const iv_key = "TDfP3V2p7ndxXmQj"
    const secret_key = "37WYwN6TFqmKyHxk"
    const algorithm = "aes-256-cbc"
    let encryption = new Encryption(iv_key, secret_key, algorithm)
    const requestBody = req.body
    const payload = JSON
        .stringify(requestBody)
        .replace(/\//g, '\\/')
    console.log(req.body)
    
    res.json({
        params:encryption.encrypt(payload),
        access_key,
        countryCode: 'ZM'//requestBody.countryCode
    });          
            
    
    //res.send('Hello From Firebase....');
});*/
export const trybaeTest=functions.https.onRequest((req,res)=>{

    res.send('Hello From Firebase....');
});
export const hellowrld=functions.https.onRequest((req,res)=>{
    console.log(req.method)
            const accessKey = "$2a$08$w2ZCHCTUBLoQQSM.OdgfYeVjIB0jWO5E3lT16SXMZG/FhwOgw7a5y"
    const iv_key = "TDfP3V2p7ndxXmQj"
    const secret_key = "37WYwN6TFqmKyHxk"
    const algorithm = "aes-256-cbc"
    
    const requestBody = req.body
    const payload = JSON
        .stringify(requestBody)
        .replace(/\//g, '\\/');
        const encryption = new Encrytion(iv_key, secret_key, algorithm)
    console.log(req.body.countryCode)
    console.log(requestBody)
    console.log(requestBody)
    corsHandler(req,res,()=>{
        
        res.json({
            params: encryption.encrypt(payload),
            accessKey,
            countryCode: 'ZM'//requestBody['countryCode']
        });  
    });
           
            
    
    
});
export const sendToDevice = functions.firestore
.document("Orders/{order_id}")
    .onCreate(async (snapshot) => {
        console.log('function triggered');
        const order = snapshot.data();
        const qSnapshot = await db
            .collection("Users")
            .doc(order.user_id)
            .collection("Tokens")
            .get();
        const tokens = qSnapshot.docs.map((snapshot) => snapshot.get('token'));
        const payload: admin.messaging.MessagingPayload = {
            notification: {
                title: `Order ${order.id}`,
                body: `The order ${order.id} with total of  ${order.totalPrice
                } has been successfully placed, you will get notifications of order updates`,
                clickAction: "FLUTTER_NOTIFICATION_CLICK",
            },
            data: {Order: `${order.id}`},
        };
        return fcm.sendToDevice(tokens, payload).then((response) => {
            // Response is a message ID string.
            console.log('Successfully sent message:', response);
          })
          .catch((error) => {
            console.log('Error sending message:', error);
          });
    });

export const onUserCreated=functions.firestore.document("Users/user_id").onCreate(async (snapshot) => {
    console.log('onUserCreated triggered');
    const user = snapshot.data();
    const qSnapshot = await db
        .collection("Users")
        .doc(user.id)
        .collection("Tokens")
        .get();
    const tokens = qSnapshot.docs.map((snapshot: { id: any; }) => snapshot.id);
    const payload: admin.messaging.MessagingPayload = {
        notification: {
            title: `User account ${user.id}`,
            body: `Congratulations ${user.email} your account has been successfully created`,
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
        data: {user_id: user.id},
    };
    return fcm.sendToDevice(tokens, payload);
});
export const UpdateOrder = functions.firestore
    .document("Orders/{order_id}")
    .onUpdate(async (snapshot) => {
        const order = snapshot.after;
        const qSnapshot = await db
            .collection("users")
            .doc(order.get("user"))
            .collection("Tokens")
            .get();
        const tokens = qSnapshot.docs.map((snapshot: { id: any; }) => snapshot.id);
        const payload: admin.messaging.MessagingPayload = {
            notification: {
                title: `Order ${order.id} update`,
                body: `The order ${order.id} with total of  k${order.get(
                    "totalPrice"
                )} has a status update `,
                clickAction: "FLUTTER_NOTIFICATION_CLICK",
            },
            data: {order: order.id},
        };
        return fcm.sendToDevice(tokens, payload);
    });


    class Encrytion{
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
    var e= new Encrytion('', '', '')
    console.log(e)