import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:toody/data/user_data.dart';
import 'package:toody/model/task_model.dart';

class CardTaskWidget extends StatefulWidget {
  final Task _task;
  const CardTaskWidget(
    this._task, {
    super.key,
  });

  @override
  State<CardTaskWidget> createState() => _CardTaskWidgetState();
}

class _CardTaskWidgetState extends State<CardTaskWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDone = widget._task.isDone;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      widget._task.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: widget._task.isDone
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      widget._task.description,
                      style: TextStyle(
                        decoration: widget._task.isDone
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    trailing: Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        activeColor: Colors.black,
                        shape: const CircleBorder(),
                        value: isDone,
                        onChanged: (value) {
                          setState(() {
                            isDone = !isDone;
                          });
                          FirestoreDatasource().isdone(widget._task.id, isDone);
                        },
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -12),
                    child: Column(
                      children: [
                        Divider(
                          thickness: 1.5,
                          color: Colors.grey.shade200,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget._task.dateTask),
                            const Gap(12),
                            Text(widget._task.timeTask),
                            const Gap(12),
                            const Spacer(),
                            Text(
                              widget._task.category,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: widget._task.category == 'Working'
                                    ? Colors.green.shade800
                                    : widget._task.category == 'General'
                                        ? Colors.amber
                                        : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
