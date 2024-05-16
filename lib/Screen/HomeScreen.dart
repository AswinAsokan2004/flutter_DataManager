import 'package:first/DataBase/DBoperations.dart';
import 'package:first/Screen/ListScreen.dart';
import 'package:first/Screen/SplashScreen.dart';
import 'package:first/noteObject.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

TextEditingController _cat = TextEditingController();
TextEditingController _dis = TextEditingController();
class HomeScreen extends StatefulWidget {
  final String pageTitle;
  const HomeScreen({Key? key, required this.pageTitle}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Future<void> _refresh() async{
    return await Future.delayed(Duration(seconds: 2));
    getAllNote();
  }
  Widget build(BuildContext context) {
    getAllNote();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 117, 157),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>insertCategory(context),
        child: Icon(Icons.add),
        ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Home',style: TextStyle(color: Colors.white,fontSize: 25,fontStyle: FontStyle.italic),),
            IconButton(
              onPressed: () async {
                showDialog(
                  context: context, 
                  builder: (ctx){
                    return SimpleDialog(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Are you sure you want to logout?'),
                        ),
                        TextButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, child: Text('No')
                        ),
                        TextButton(onPressed: () async {
                          final sharedPr = await SharedPreferences.getInstance();
                          sharedPr.remove('login_name');
                          sharedPr.remove('login_password');
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>SplashScreen()));
                        }, child: Text('Yes')
                        ),

                      ],
                    );
                  }
                  );
              }, 
              icon: Icon(Icons.logout,color: Colors.white,))
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 237, 117, 157),
      ),
      body: LiquidPullToRefresh(
        onRefresh: _refresh,
        height: 300,
        color: Color.fromARGB(255, 113, 32, 156),
        backgroundColor: Color.fromARGB(255, 243, 84, 213),
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        child: ValueListenableBuilder(
          valueListenable: noteNotifier,
          builder: (BuildContext ctx,List<Note> value,Widget? child) {
            return ListView.separated(
            
            itemBuilder: (ctx,index){
              final data = value[index];
              return Card(
                surfaceTintColor: Colors.black12,
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Adjust the value as needed
                ),
                elevation: 30, 
                color: Color.fromARGB(255, 211, 15, 245),
                shadowColor: Color.fromARGB(255, 176, 27, 231),
                margin: EdgeInsets.all(10),
                child: ListTile(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_){return ListScreen(title:data.category);})
                    );
                  },
                  leading: Text('${data.category}',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.white),),
                  title: Text('${data.description}',style: TextStyle(color: Colors.white)),
                  subtitle: Text('${data.date}',style: TextStyle(color: Colors.white),),
                  trailing: IconButton(
                    onPressed: (){
                      showDialog(
                          context: context, 
                          builder: (cxt){
                            return SimpleDialog(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Do you really want to Delete this?'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        }, 
                                        icon: Icon(Icons.keyboard_return), 
                                        label: Text('Back')
                                        ),
                                        ElevatedButton.icon(
                                        onPressed: (){
                                          deleteData(data.id);
                                          Navigator.of(context).pop();
                                        }, 
                                        icon: Icon(Icons.delete,color: Colors.red,), 
                                        label: Text('Delete')
                                        )
                                    ],
                                  ),
                                )
                              ],
                            );
                          }
                          );
                    }, 
                    icon: Icon(Icons.delete,color: Color.fromARGB(255, 233, 94, 84),)),
                ),
              );
            }, 
            separatorBuilder: (ctx,index){
              return Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                child: Divider(),
              );
            }, 
            itemCount: noteNotifier.value.length,
            );
          },
        ),
      ),
    );
  }
}
Future<void> insertCategory(BuildContext context) async{
  showDialog(context: context, 
  builder: (ctx){
    return SimpleDialog(
      title: Text('Add The Category'),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _cat,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Category',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _dis,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Discription',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: (){
              DateTime now = DateTime.now();
              int year= now.year; 
              int month = now.month; 
              int day = now.day; 

              String timeString = '$day/$month/$year';
              insertNote(_cat.text,_dis.text,timeString);
              Navigator.of(context).pop();
            }, 
            icon: Icon(Icons.insert_chart), 
            label:Text('Insert')),
        ),
      ],
    );
  }
  );
}
