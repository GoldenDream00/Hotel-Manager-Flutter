import 'package:flutter/material.dart';
import 'Admin/login.dart';
import 'User/login.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/onBoardBG.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome\nBack",
              style: TextStyle(
                fontSize: 48,
                height: 1.1,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "to AGDA Hotels",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => moveToUserLogin(context),
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Continue as Customer",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => moveToAdminLogin(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.lightGreen,
                    width: 2,
                  ),
                  shape: const StadiumBorder(),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Continue as Manager",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  moveToUserLogin(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserLogin()),
    );
  }

  moveToAdminLogin(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdminLogin()),
    );
  }
}
