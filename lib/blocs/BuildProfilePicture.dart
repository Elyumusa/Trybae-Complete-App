import 'dart:io';

import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:TrybaeCustomerApp/Components/edit_profile.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final Function onPressed;
  final String imagePath;
  final bool edit;
  const ProfilePicture({
    Key key,
    this.onPressed,
    this.imagePath,
    this.edit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(context, 140),
      height: getProportionateScreenWidth(context, 140),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child:
            Stack(fit: StackFit.expand, overflow: Overflow.visible, children: [
          /* Icon(
            Icons.account_circle,
            size: 150,
            color: Colors.grey,
          ),*/
          imagePath == null
              ? CircleAvatar(
                  backgroundColor: Color(0xFFF5F6F9),
                  child: Icon(
                    Icons.account_circle_rounded,
                    size: 100,
                  ),
                )
              : CircleAvatar(
                  backgroundColor: Color(0xFFF5F6F9),
                  backgroundImage: NetworkImage(imagePath),
                ),
          edit == true
              ? Positioned(
                  //top: 85,
                  bottom: 4,
                  right: -10,
                  child: SizedBox(
                    height: getProportionateScreenWidth(context, 45),
                    width: getProportionateScreenWidth(context, 45),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      padding: EdgeInsets.zero,
                      color: Color(0xFFF5F6F9),
                      onPressed: onPressed,
                      child: Icon(
                        Icons.photo_camera,
                      ),
                    ),
                  ),
                )
              : const Text(''),
        ]),
      ),
    );
  }
}

class SpecificListTile extends StatelessWidget {
  //final Function onTap;
  final String title;
  final Icon icon;

  const SpecificListTile({
    @required this.icon,
    @required this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        onPressed: () {
          switch (title) {
            case 'My Account':
              return Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return EditProfile();
                },
              ));
              break;
            case 'Notifications':
              Navigator.pushNamed(context, '');
              break;
            case 'Settings':
              Navigator.pushNamed(context, '');
              break;
            case 'Help Center':
              Navigator.pushNamed(context, '');
              break;
            case 'Log Out':
              Navigator.pushNamed(context, '');
              break;
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(children: [
          icon,
          SizedBox(
            width: 30,
          ),
          Expanded(child: Text(title)),
          Icon(
            Icons.arrow_forward,
            color: Colors.black87,
          ),
        ]),
        color: Color(0xFFF5F6F9),
      ),
    );
  }
}
