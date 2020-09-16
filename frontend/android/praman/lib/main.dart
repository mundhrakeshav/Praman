import 'package:flutter/material.dart';
import 'package:praman/Services/auth.dart';
import 'package:provider/provider.dart';
import 'Models/Organization.dart';
import 'Services/addRecords.dart';
import 'Services/webSocketsEthVigil.dart';
import 'androidUIs/AndroidUi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthBase>(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider<WebSocketsEthVigil>(
          create: (context) => WebSocketsEthVigil(),
        ),
        Provider<AddRecordsBase>(
          create: (context) => AddRecords(),
        ),
        ChangeNotifierProvider<Organization>(
          create: (context) => Organization(),
        ),
      ],
      child: MaterialApp(
        title: 'PathShala',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: RenderPage()),
      ),
    );
  }
}

class RenderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // if (kIsWeb) return WebUi();
    return AndroidUi();
  }
}
