# Awesome Notifications with Firebase in Flutter Apps - Assignment - 19 May 2025

## Setup Firebase Messaging
1. Menjalankan command `flutter pub add firebase_messaging` di terminal project
2. Rerun project
3. Inisialisasi firebase dengan menambahkan kode berikut ke fungsi main:
```dart
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
```
4. Ambil token firebase messaging dari local device `final fcmToken = await FirebaseMessaging.instance.getToken();` kemudian tampilkan untuk dicopy, contoh di bawah akan menampilkan token di runtime terminal:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // get token android
  final fcmToken = await FirebaseMessaging.instance.getToken();
  if(fcmToken!=null){
    //do something
    print("token: ${fcmToken}");
  }

  runApp(const MyApp());
}
```
5. Menambahkan token yang diperoleh ke Firebase Cloud Messaging [FCM](https://firebase.google.com/products/cloud-messaging), kemudian lakukan pengetesan
![image](https://github.com/user-attachments/assets/432fe361-e4e3-425d-a570-dc0e71fbcd84)
![image](https://github.com/user-attachments/assets/9db9fc77-0371-41cf-ad17-a7c573ef05d8)

