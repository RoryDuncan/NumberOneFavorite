import { cert } from "firebase-admin/app";
import {
	FIREBASE_PRIVATE_KEY,
	FIREBASE_CLIENT_EMAIL,
	FIREBASE_PROJECT_ID
} from "$env/static/private";

if (!FIREBASE_PRIVATE_KEY) {
	throw new Error(".env: FIREBASE_PRIVATE_KEY is missing");
}

if (!FIREBASE_CLIENT_EMAIL) {
	throw new Error(".env: FIREBASE_CLIENT_EMAIL is missing");
}

if (!FIREBASE_PROJECT_ID) {
	throw new Error(".env: FIREBASE_PROJECT_ID is missing");
}

export default cert({
	privateKey: FIREBASE_PRIVATE_KEY.replace(/\\n/g, "\n"),
	clientEmail: FIREBASE_CLIENT_EMAIL,
	projectId: FIREBASE_PROJECT_ID
});
