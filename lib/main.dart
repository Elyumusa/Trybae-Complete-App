import 'package:TrybaeCustomerApp/Components/MainScreenWrapper.dart';
import 'package:TrybaeCustomerApp/Screens/authentication/sign_up.dart';
import 'package:TrybaeCustomerApp/Screens/cart_screen.dart';
import 'package:TrybaeCustomerApp/Screens/checkout/checkout.dart';
import 'package:TrybaeCustomerApp/blocs/UserAuthStatebloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'Components/edit_profile.dart';
import 'Screens/BranchOffMainPage.dart';
import 'Screens/DesignerMainPage.dart';
import 'Screens/EditProfile.dart';
import 'Screens/Notifications.dart';
import 'Screens/authentication/otp_page.dart';
import 'Screens/home_screen.dart/HomePage.dart';
import 'Screens/ProductScreen.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'Screens/RavePaymentPage.dart';
import 'Screens/account_screen.dart';
import 'Screens/authentication/SignUp.dart';
import 'Screens/authentication/Sign_In.dart';
import 'Screens/landing_page.dart/Landing_screen.dart';
import 'Screens/mesages_and_notifications.dart';
import 'Screens/my_orders.dart';
import 'Screens/new_product_screen.dart';
import 'Screens/pick_image.dart';
import 'blocs/CartBloc.dart';
import 'blocs/ProductBloc.dart';
import 'blocs/TabBloc.dart';
import 'models/CollectionModel.dart';
import 'models/DesignerModel.dart';
import 'models/ProductModel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);
Future<FirebaseApp> initialization;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initialization = Firebase.initializeApp();
// Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    var initializingAndroidSetting =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializationSettings =
        InitializationSettings(android: initializingAndroidSetting);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return AlertDialog(
            content: Text('Errrroor'),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          FirebaseFirestore.instance.useFirestoreEmulator('localhost', 9000);
          FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
          return MyHomePage(
            bloc: BlocProvider(
                productBloc: ProductBloc(),
                tabBloc: TabBloc(),
                userAuthStatebloc: UserAuthStatebloc(AuthService()),
                cartBloc: CartBloc()),
          );
        }
        return MaterialApp(home: CircularProgressIndicator());
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final BlocProvider bloc;

  MyHomePage({@required this.bloc});
  @override
  _MyHomePageState createState() => _MyHomePageState();
  static _MyHomePageState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppInheritor>().data;
  }
}

class AppInheritor extends InheritedWidget {
  final _MyHomePageState data;
  final Widget child;
  AppInheritor({Key key, @required this.data, @required this.child})
      : super(key: key, child: child);
  @override
  bool updateShouldNotify(AppInheritor oldWidget) {
    return true;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  BlocProvider get blocProvider => widget.bloc;
  @override
  Widget build(BuildContext context) {
    return AppInheritor(
        data: this,
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                primarySwatch: Colors.blueGrey,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: TextTheme(
                    headline6: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    bodyText2: TextStyle(color: Color(0xFF1D150B)),
                    button: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
            home: CheckOutPage()));
  }
}

class BlocProvider {
  ProductBloc productBloc;
  TabBloc tabBloc;
  UserAuthStatebloc userAuthStatebloc;
  CartBloc cartBloc;
  //MyUserBloc userBloc;
  BlocProvider(
      {this.productBloc, this.tabBloc, this.userAuthStatebloc, this.cartBloc});
}
