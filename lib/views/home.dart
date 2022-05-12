import 'package:flutter/material.dart';
import 'package:kpie/utils/config.dart';
import 'package:kpie/widgets/textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = TextEditingController();
  GlobalKey<ScaffoldState> key = GlobalKey();
  Map<String, dynamic> postItems = {
    'Post Text': [Icons.person, 'postText'],
    'Post Color': [Icons.security, 'post_color'],
    'Event id': [Icons.lock, 'event_id'],
    'Post Privacy': [Icons.help, 'postPrivacy'],
  };
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      key: key,
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              key.currentState!.showBottomSheet(
                ((context) {
                  return SizedBox(
                    height: 250,
                    child: Column(
                      children: [
                        MyTextField(
                          controller: search,
                          labelText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                        ),
                        Expanded(
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: postItems.keys.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                              ),
                              itemBuilder: (_, index) {
                                var pK = postItems.keys.toList()[index];
                                var pV = postItems.values.toList()[index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Uploading content'),
                                            duration:
                                                Duration(milliseconds: 100),
                                          ),
                                        );
                                        await ApiConfig.postItem({
                                          pV[1]: 'hello',
                                        }).then((value) {
                                          if (value['status']) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text('Upload successfull'),
                                                duration:
                                                    Duration(milliseconds: 100),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Failed uploading content'),
                                                duration:
                                                    Duration(milliseconds: 100),
                                              ),
                                            );
                                          }
                                        });
                                      },
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Icon(pV[0]),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Expanded(child: Text(pK)),
                                  ],
                                );
                              }),
                        )
                      ],
                    ),
                  );
                }),
                elevation: 5.0,
              );
            },
          ),
        ],
      ),
      body: Container(),
    );
  }
}
