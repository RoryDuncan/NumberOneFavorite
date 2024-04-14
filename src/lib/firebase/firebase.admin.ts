//Import Firebase Admin Service Account with $env functionality in Svelte
// import { GOOGLE_APPLICATION_CREDENTIALS } from '$env/static/private'

import { initializeApp, type App } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";
import { default as cert } from "./firebase-cert";

export const adminSDK: App = initializeApp({
	credential: cert
});

export const firestore = getFirestore();

// function createAdminSDK(): App {
// 	const apps = getApps();

// 	if (apps.length > 0) {
// 		return apps.at(0)!;
// 	}

// 	const app = initializeApp({
// 		credential: cert
// 	});

// 	return app;
// }
