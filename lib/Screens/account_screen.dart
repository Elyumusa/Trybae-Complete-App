import 'package:TrybaeCustomerApp/Components/edit_profile.dart';
import 'package:TrybaeCustomerApp/blocs/BuildProfilePicture.dart';
import 'package:flutter/Material.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ProfilePicture(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return EditProfile();
                    },
                  ));
                },
                child: SpecificListTile(
                  icon: Icon(
                    Icons.account_circle_outlined,
                    size: 30,
                  ),
                  title: 'Edit Profile',
                ),
              ),
              SpecificListTile(
                icon: Icon(
                  Icons.notifications_active_outlined,
                  size: 30,
                ),
                title: 'My Orders',
              ),
              SpecificListTile(
                icon: Icon(
                  Icons.help_outline_outlined,
                ),
                title: 'Help Center',
              ),
              SpecificListTile(
                icon: Icon(
                  Icons.logout,
                ),
                title: 'Log Out',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
