import 'package:first/DataBase/DBoperationSub.dart';
import 'package:first/noteObject.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
ValueNotifier<List<subNote>> subNoteNotifier = ValueNotifier([]);
TextEditingController _name = TextEditingController();
TextEditingController _description = TextEditingController();

class ListScreen extends StatelessWidget {
  final String title;

  const ListScreen({Key? key, required this.title}) : super(key: key);

  @override
  Future<void> _refresh() async{
    Future.delayed(Duration(seconds: 2));
    getAllNoteSub(title);
  }
  Widget build(BuildContext context) {
    getAllNoteSub(title);
    return Scaffold(
      appBar: AppBar(
        title: Text(title), // Set the title of the app bar
      ),
      body: LiquidPullToRefresh(
        onRefresh: _refresh,
        height: 300,
        animSpeedFactor: 2,
        showChildOpacityTransition: true,
        color: Color.fromARGB(255, 84, 82, 82),
        backgroundColor: Color.fromARGB(255, 199, 197, 197),
        child: SafeArea(
         child: Padding(
           padding: const EdgeInsets.all(8.0),
             child: Column(
                children: [
                TextFormField(
                 controller: _name,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name', // Add a label for better user experience
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _description,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description', // Add a label for better user experience
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              
              DateTime time = DateTime.now();
              print(time);
              String timeNow = '${time.hour}:${time.minute}:${time.second}';
              insertNoteSub(_name.text, _description.text, timeNow, title);
              _name.clear();
              _description.clear();
            }, 
            icon: Icon(Icons.inbox), 
            label: Text('Insert'),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: subNoteNotifier, 
              builder: (BuildContext ctx, List<subNote> data, Widget? _) {
                return ListView.separated(
                  itemBuilder: (cxt, index) {
                    final note = data[index];
                    return GestureDetector(
                      onLongPress: (){
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
                                          deleteDataSub(note.id, note.category);
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
                      child: Card(
                        color: Colors.grey,
                        child: ListTile(
                          title: Text(note.name),
                          subtitle: Text(note.description),
                          trailing: Text(note.time),
                        ),
                      ),
                    );
                  }, 
                  separatorBuilder: (cxt, index) {
                    return Divider();
                  }, 
                  itemCount: subNoteNotifier.value.length,
                );
              },
            ),
          ),
        ],
            ),
          ),
        ),
      ),

    );
  }
}
