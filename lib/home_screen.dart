import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive Database learning"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox("karan");
          box.put("name", "Karan Developer");
          box.put("experience", "3 years");

          box.put("details", {
            "name": "karan",
            "experience": "3 years",
            "role": "Fullstack Developer",
          });
          print(box.get("name"));
          print(box.get("experience"));
          print(box.get("details"));
          print(box.get("details")["role"]);

          var box2 = await Hive.openBox("pankaj");
          box2.put("name", "pankaj Developer");
          box2.put("experience", "4 years");

          box2.put("details", {
            "name": "pankaj",
            "experience": "4 years",
            "role": "Nodejs Developer",
          });
          print(box2.get("name"));
          print(box2.get("experience"));
          print(box2.get("details"));
          print(box2.get("details")["role"]);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: Hive.openBox("karan"),
              builder: (context, snapshots) {
                return Container(
                  margin: const EdgeInsets.all(15),
                  color: Colors.grey,
                  child: Column(
                    children: [
                      Text(snapshots.data!.get("karan").toString()),
                      Text(snapshots.data!.get("experience").toString()),
                      Text(snapshots.data!.get("details").toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshots.data!.get("experience").toString()),
                          IconButton(
                              onPressed: () {
                                snapshots.data!.delete("experience");
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              }),
          FutureBuilder(
              future: Hive.openBox("pankaj"),
              builder: (context, snapshots) {
                return Container(
                    margin: const EdgeInsets.all(15),
                    color: Colors.grey,
                    child: ListTile(
                      leading: Text(snapshots.data!.get("pankaj").toString()),
                      title: Text(snapshots.data!.get("details").toString()),
                      subtitle: Text(
                          snapshots.data!.get("details")["role"].toString()),
                      trailing: IconButton(
                          onPressed: () {
                            snapshots.data!
                                .put("pankaj", "pankaj node js developer");
                            setState(() {});
                          },
                          icon: const Icon(Icons.edit)),
                    ));
              }),
        ],
      ),
    );
  }
}
