import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback? onPressed;

  const NoDataWidget({
    super.key,
    this.message = "No data available",
    this.buttonText = "Refresh",
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.find_in_page_outlined,
              size: 64.0,
              color: Colors.grey,
            ),
            const SizedBox(height: 16.0),
            Text(
              message,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            if (onPressed != null)
              ElevatedButton(
                onPressed: onPressed,
                child: Text(buttonText),
              ),
          ],
        ),
      ),
    );
  }
}
