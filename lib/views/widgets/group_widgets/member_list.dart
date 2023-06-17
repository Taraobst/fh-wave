import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../controllers/group_controller.dart';
import '../../group_calendar_screen.dart';
import 'popups.dart';

final GroupController groupController = GroupController();

class MemberList extends StatefulWidget {
  final String groupId;

  const MemberList({Key? key, required this.groupId}) : super(key: key);

  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.topLeft,
          height: 70,
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  "Mitglieder",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                  onPressed: () => setState(() {}),
                  icon: const Icon(Icons.refresh))
            ],
          ),
        ),
        Container(
          constraints: const BoxConstraints(
            minHeight: 300,
            maxHeight: 300,
          ),
          child: FutureBuilder<List<String>>(
            future: groupController.getMemberNames(widget.groupId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Image.asset(
                      "assets/fhwave-loading-schwarz.gif",
                      gaplessPlayback: true,
                      width: 60.0,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Lade Info ...",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: AppColors.fhwaveNeutral200, // Farbe des Strichs
                    thickness: 1, // Dicke des Strichs
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var memberName = snapshot.data![index];
                    return ListTile(
                      leading: const Icon(Icons.person),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              memberName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          removeButton(context, memberName)
                        ],
                      ),
                      onTap: () {
                        // print(memberName);
                      },
                    );
                  },
                );
              } else {
                return const Text(
                  'Keine Mitglieder vorhanden',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget removeButton(BuildContext context, String memberName) {
    if (memberName != currentUser?.displayName) {
      return IconButton(
          onPressed: () {
            confirmPopup(
                context,
                Icons.group_remove,
                "Willst du $memberName wirklich aus der Gruppe entfernen?",
                "Du kannst diesen Schritt nicht rückgängig machen.", () {
              groupController.leaveGroup(widget.groupId, memberName);
            });
          },
          icon: const Icon(Icons.remove));
    } else {
      return const Text("");
    }
  }
}

Future<String> loadMemberId(String memberName) async {
  var memberId = await groupController.getUserIdFromUsername(memberName);
  return memberId;
}

// class MemberList extends StatelessWidget {
//   final String groupId;
//
//   const MemberList({super.key, required this.groupId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(
//           height: 20,
//         ),
//         Container(
//           alignment: Alignment.topLeft,
//           height: 70,
//           child: Row(
//             children: [
//               const Expanded(
//                 child: Text(
//                   "Mitglieder",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                 ),
//               ), IconButton(onPressed: () =>
//                   setState(() {
//
//                   }), icon: const Icon(Icons.refresh))
//             ],
//           ),
//         ),
//         Container(
//           constraints: const BoxConstraints(
//             minHeight: 300,
//             maxHeight: 300,
//           ),
//           child: FutureBuilder<List<String>>(
//             future: groupController.getMemberNames(groupId),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                     child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 150,
//                     ),
//                     Image.asset(
//                       "assets/fhwave-loading-schwarz.gif",
//                       gaplessPlayback: true,
//                       width: 60.0,
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     const Text(
//                       "Lade Info ...",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 16.0,
//                       ),
//                     ),
//                   ],
//                 ));
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                 return ListView.separated(
//                   separatorBuilder: (context, index) => const Divider(
//                     color: AppColors.fhwaveNeutral200, // Farbe des Strichs
//                     thickness: 1, // Dicke des Strichs
//                   ),
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     var memberName = snapshot.data![index];
//                     return ListTile(
//                       leading: const Icon(Icons.person),
//                       title: Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               memberName,
//                               style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 16.0,
//                               ),
//                             ),
//                           ),
//                           removeButton(context, memberName)
//                         ],
//                       ),
//                       onTap: () {
//                         // print(memberName);
//                       },
//                     );
//                   },
//                 );
//               } else {
//                 return const Text(
//                   'Keine Mitglieder vorhanden',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 16.0,
//                   ),
//                 );
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget removeButton(BuildContext context, String memberName) {
//     if (memberName != currentUser?.displayName) {
//       return IconButton(
//           onPressed: () {
//             //TODO Async Function draus machen
//             confirmPopup(
//                 context,
//                 Icons.group_remove,
//                 "Willst du $memberName wirklich aus der Gruppe entfernen?",
//                 "Du kannst diesen Schritt nicht rückgängig machen.", () {
//               groupController.leaveGroup(groupId, memberName);
//             });
//           },
//           icon: const Icon(Icons.remove));
//     } else {
//       return const Text("");
//     }
//   }
// }
