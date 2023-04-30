import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomNote extends StatelessWidget {
  final Function() onEditTap;
  final String title, description;
  final int color;
  final DateTime dateTime;
  const CustomNote({
    super.key,
    required this.title,
    required this.description,
    required this.onEditTap,
    required this.color,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEditTap,
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: Color(color),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.black,
              ),
              Text(
                description,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Text(
                DateFormat.MMMEd().format(dateTime),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
