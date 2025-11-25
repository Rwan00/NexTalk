import {setGlobalOptions} from "firebase-functions";
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();
const fcm = admin.messaging();

// Health Check
export const checkHealth = functions.https.onCall(async () => {
  return "The function is online.";
});

// Send Notification
export const sendNotification = functions.https.onCall(
  async (data) => {
    const title = data.data.title;
    const body = data.data.body;
    const image = data.data.image;
    const token = data.data.token;

    try {
      const payload = {
        token,
        notification: {
          title,
          body,
          image,
        },
        data: {body},
      };

      return fcm.send(payload)
        .then((response) => {
          return {
            success: true,
            response:
              "Successfully sent message: " + response,
          };
        })
        .catch((error) => {
          return {error};
        });
    } catch (error) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "error: " + error
      );
    }
  }
);

// Global function config
setGlobalOptions({maxInstances: 10});
