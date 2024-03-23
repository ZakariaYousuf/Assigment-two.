import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

// User class
class User {
  final String name;
  final String imageUrl;

  User({
    required this.name,
    required this.imageUrl,
  });
}

// Story class
class Story {
  final User user;
  final String imageUrl;
  final bool isViewed;

  Story({
    required this.user,
    required this.imageUrl,
    this.isViewed = false,
  });
}

// Post class
class Post {
  final User user;
  final String? caption;
  final String timeAgo;
  final String? imageUrl;
  final int likes;
  final int comments;
  final int shares;

  Post({
    required this.user,
    this.caption,
    required this.timeAgo,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}

class HomePage extends StatelessWidget {
  final List<User> onlineUsers = generateUsers(10);
  final List<Story> stories = generateStories(5);
  final List<Post> posts = generatePosts(10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostItem(post: posts[index]);
        },
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.user.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          if (post.caption != null) Text(post.caption!),
          if (post.imageUrl != null)
            Image.network(
              post.imageUrl!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          SizedBox(height: 8.0),
          Text(
            '${post.likes} likes • ${post.comments} comments • ${post.shares} shares',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 8.0),
          Text(
            '${post.timeAgo} ago',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// Functions for generating dummy data

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

List<Story> generateStories(int count) {
  final faker = Faker();
  final onlineUsers = generateUsers(count);
  return List.generate(
    count,
    (index) => Story(
      user: onlineUsers[index],
      imageUrl: faker.image.image(),
    ),
  );
}

List<Post> generatePosts(int count) {
  final faker = Faker();
  final onlineUsers = generateUsers(count);
  return List.generate(
    count,
    (index) => Post(
      user: onlineUsers[index],
      caption: faker.lorem.sentence(),
      timeAgo: '${faker.randomGenerator.integer(24)}h',
      imageUrl: faker.randomGenerator.boolean() ? faker.image.image() : null,
      likes: faker.randomGenerator.integer(1000),
      comments: faker.randomGenerator.integer(300),
      shares: faker.randomGenerator.integer(200),
    ),
  );
}
