import 'package:flutter/material.dart';

class SelectImageWithOptions extends StatelessWidget {
  final Function(bool)? selectPicture;
  const SelectImageWithOptions({Key? key, this.selectPicture});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              'Select Picture',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                selectPicture?.call(true);
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Select picture from gallery',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.grey.shade700,
                  )
                ],
              ),
            ),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                selectPicture?.call(false);
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Take picture',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.grey.shade700,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
