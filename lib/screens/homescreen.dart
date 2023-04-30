import 'package:flutter/material.dart';
import 'package:testbloc/db/notedb.dart';
import 'package:testbloc/screens/note_screen.dart';

import '../widget/custom_new_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Notes",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.white60,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  setState(() {});
                  isActive = !isActive;
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:
                      Icon(isActive ? Icons.star : Icons.star_border_outlined),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: isActive
              ? NoteDb.instace.getStaredNote()
              : NoteDb.instace.getNote(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) => CustomNote(
                      dateTime: snapshot.data![index].dateTime,
                      color: snapshot.data![index].color,
                      onEditTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoteScreen(
                              note: snapshot.data![index],
                            ),
                          ),
                        );
                      },
                      title: snapshot.data![index].title,
                      description: snapshot.data![index].description,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    "No Data",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NoteScreen(),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.add,
              size: 35,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
