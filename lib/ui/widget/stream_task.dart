import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:toody/data/user_data.dart';
import 'package:toody/ui/widget/cardtask_widget.dart';

class StreamTask extends StatelessWidget {
  const StreamTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreDatasource().stream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final taskList = FirestoreDatasource().getTask(snapshot);
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final task = taskList[index];
              return Slidable(
                endActionPane:
                    ActionPane(motion: const StretchMotion(), children: [
                  SlidableAction(
                    key: UniqueKey(),
                    onPressed: ((context) {
                      FirestoreDatasource().deleteTask(task.id);
                      FlutterToastr.show(
                        'Delete Task Successfully',
                        context,
                        position: FlutterToastr.bottom,
                        duration: FlutterToastr.lengthLong,
                        backgroundColor: Colors.green.withOpacity(0.7),
                      );
                    }),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.red,
                    label: "Delete",
                    icon: Icons.delete,
                    borderRadius: BorderRadius.circular(100),
                  )
                ]),
                child: CardTaskWidget(task),
              );
            },
            itemCount: taskList.length,
          );
        });
  }
}
