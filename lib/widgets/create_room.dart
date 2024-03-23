import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:shimmer/shimmer.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({Key? key}) : super(key: key);

  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  late List<User> onlineUsers;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading data
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        onlineUsers = generateUsers(10);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 100,
      child: isLoading
          ? Shimmer.fromColors(
              period: Duration(milliseconds: 500),
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2, // Just for the shimmer effect
                itemBuilder: (context, index) => _buildShimmerItem(),
              ),
            )
          : _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: onlineUsers.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16, left: 10),
            child: GestureDetector(
              onTap: () => print('create Room'),
              child: Container(
                height: 62,
                width: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue[200]!, width: 4),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.video_call_sharp,
                      color: Colors.pink,
                      size: 40,
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 80,
                      child: Text(
                        'Create Room',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(onlineUsers[index - 1].imageUrl),
                backgroundColor: Colors.grey,
              ),
              Positioned(
                bottom: 20,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.green,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: 70,
            height: 12,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  // Generate fake user data using Faker
  List<User> generateUsers(int count) {
    final faker = Faker();
    return List.generate(
      count,
      (index) => User(
        name: faker.person.name(),
        imageUrl: faker.image.image(),
      ),
    );
  }
}

// User class
class User {
  final String name;
  final String imageUrl;

  User({
    required this.name,
    required this.imageUrl,
  });
}
