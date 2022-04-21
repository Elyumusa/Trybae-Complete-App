import 'package:TrybaeCustomerApp/models/DesignerModel.dart';
import 'package:flutter/material.dart';

class DesignerCard extends StatelessWidget {
  const DesignerCard({
    Key key,
    @required this.designer,
  }) : super(key: key);

  final Designer designer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 155,
              width: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.asset(
                  designer.designerImage,
                  fit: BoxFit.cover,
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text('${designer.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
