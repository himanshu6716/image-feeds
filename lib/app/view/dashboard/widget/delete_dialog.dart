import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_feed/app/utils/colours.dart';
import 'package:image_feed/app/utils/utils.dart';
import '../bloc/dashboard_bloc.dart';

class DeleteDialog {

  static void show(BuildContext context, int index) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: pageBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(smallBorderRadius),
          ),
          title: Text("Delete Post" ,style: Theme.of(context).textTheme.titleLarge,),
          content:  Text(
            "Are you sure you want to delete this post?",style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child:Text("Cancel",style: Theme.of(context).textTheme.bodyLarge),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                context.read<DashboardBloc>().add(
                  DeleteImageEvent(index),
                );
              },
              child: Text(
                "Delete",
                style: TextStyle(color:errorColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
