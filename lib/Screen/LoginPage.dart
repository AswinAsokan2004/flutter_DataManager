import 'package:first/Screen/HomeScreen.dart';
import 'package:first/Screen/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
TextEditingController _userName = TextEditingController();
TextEditingController _password= TextEditingController();
class MyGesters extends StatefulWidget {
  const MyGesters({Key? key}) : super(key: key);

  @override
  State<MyGesters> createState() => _MyGestersState();
}

class _MyGestersState extends State<MyGesters> {
  @override
  void initState() {
    // TODO: implement initState
    
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }
  bool startVisible = true;
  double x1 = 0, y1 = 0, x2 = 0, y2 = 0, x3 = 0, y3 = 0, x4 = 0, y4 = 0,x=0,y=0,h=0,w=0;

  void animator() {
    setState(() {
      // Set new positions for animation
      startVisible = false;
      x1 = -1;
      y1 = -1;
      x2 = -1;
      y2 = 1;
      x3 = 1;
      y3 = -1;
      x4 = 1;
      y4 = 1;
    });

    // Reset positions after animation completes
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        x1 = 0;
        y1 = 0;
        x2 = 0;
        y2 = 0;
        x3 = 0;
        y3 = 0;
        x4 = 0;
        y4 = 0;
      });
      Future.delayed(const Duration(milliseconds: 800),() {
        setState(() {
          h=double.infinity;
          w=double.infinity;

        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: animator,
      child: Scaffold(
        backgroundColor: Colors.deepPurple[200],
        body: SafeArea(
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                alignment: Alignment(x1, y1),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                  height: 150,
                  width: 150,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                alignment: Alignment(x2, y2),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                  height: 150,
                  width: 150,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                alignment: Alignment(x3, y3),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                  height: 150,
                  width: 150,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                alignment: Alignment(x4, y4),
                child: Container(
                  decoration: BoxDecoration(
                    shape:BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                  height: 150,
                  width: 150,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 800),
                alignment: Alignment(0, 0),
                child: PersonalForm(height: h,width: w),
              ),
              Visibility(
                visible: startVisible,
                child: Center(
                  child: Text(
                    'Get Start',
                    style: TextStyle(
                      fontSize: 60, // Adjust the size as needed
                      color: Colors.white,
                      fontWeight: FontWeight.bold, // You can adjust the font weight as well
                      // You can add more styling like shadows, etc. here if needed
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
class PersonalForm extends StatelessWidget {
  final double height;
  final double width;

  const PersonalForm({Key? key, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(  
         decoration: BoxDecoration(
              shape:BoxShape.rectangle,
                   // borderRadius: BorderRadius.circular(30),
              color: Color.fromARGB(255, 206, 183, 246),
        ),
        height:height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 30
                    ),
                ),
                SizedBox(height: 150,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'User Name',
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () async {
                    final sharedPr = await SharedPreferences.getInstance();
                    sharedPr.setString('login_name', _userName.text);
                    sharedPr.setString('login_password',_password.text);
                    if(await isRegisted()){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomeScreen(pageTitle: 'Home')));
                    }
                  }, 
                  child: Text('Login')
                  )
              ],
            ),
          ),
        ),
      );
  }
  Future<String> getTitle() async{
    final sharedpreferences = await SharedPreferences.getInstance();
    String? name = sharedpreferences.getString('login_name');
    if(name!=null){
      return name;
    }else{
      return 'home';
    }
  }
}

