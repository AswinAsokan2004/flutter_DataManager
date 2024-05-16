import 'package:first/Screen/HomeScreen.dart';
import 'package:first/Screen/ListScreen.dart';
import 'package:first/Screen/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  @override

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), () async {
      if(await isRegisted()){
        
        
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen(pageTitle: 'Home')));

    }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const MyGesters()));
    }
  }
      
    );
  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink,Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            ),    
          ),
        child:const Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 100,
                    ),
                   Text(
                    'Note Maker',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 3.0,
                          color: Colors.black,
                        ),
                     ],
                  ),
                  )

                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Every moment is a note...',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily:"Raleway",
                        ),
                        ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
Future<bool> isRegisted() async{
  final sharedPr = await SharedPreferences.getInstance();
  final String? name = sharedPr.getString('login_name');
  final String? password = sharedPr.getString('login_password');
  if(name != null && password !=null){
    return true;
  }else{
    return false ;
  }
}

