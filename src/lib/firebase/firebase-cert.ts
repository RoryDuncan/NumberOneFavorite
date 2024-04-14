import { cert } from "firebase-admin/app";

if (!process.env.FIREBASE_PRIVATE_KEY) {
	throw new Error(".env: FIREBASE_PRIVATE_KEY is missing");
}

if (!process.env.FIREBASE_CLIENT_EMAIL) {
	throw new Error(".env: FIREBASE_CLIENT_EMAIL is missing");
}

if (!process.env.FIREBASE_PROJECT_ID) {
	throw new Error(".env: FIREBASE_PROJECT_ID is missing");
}

export default cert({
	privateKey: process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, "\n"),
	clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
	projectId: process.env.FIREBASE_PROJECT_ID
});
