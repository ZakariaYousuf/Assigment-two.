import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

class User {
  final String name;
  final String imageUrl;

  User({
    required this.name,
    required this.imageUrl,
  });
}

class Post {
  final User? user;
  final String? caption;
  final String? timeAgo;
  final String? imageUrl;
  final int likes;
  final int comments;
  final int shares;

  Post({
    required this.user,
    this.caption,
    this.timeAgo,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}

List<Post> posts = generatePosts(10); // Generate dummy posts

List<Post> generatePosts(int count) {
  final faker = Faker();
  return List.generate(
    count,
    (index) => Post(
      user: User(
        name: faker.person.name(),
        imageUrl: faker.image.image(),
      ),
      caption: faker.lorem.sentence(),
      timeAgo: '${faker.randomGenerator.integer(24)}h',
      imageUrl: faker.randomGenerator.boolean() ? faker.image.image() : null,
      likes: faker.randomGenerator.integer(1000),
      comments: faker.randomGenerator.integer(300),
      shares: faker.randomGenerator.integer(200),
    ),
  );
}

class Posts extends StatelessWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            margin: const EdgeInsets.only(top: 15),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            NetworkImage(posts[index].user!.imageUrl),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(posts[index].user!.name),
                                Text(
                                  '${posts[index].timeAgo}' ' •🌎',
                                  style: TextStyle(color: Colors.grey[700]),
                                )
                              ],
                            ),
                            IconButton(
                              onPressed: () => print('menu'),
                              icon: const Icon(Icons.more_horiz),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(posts[index].caption!),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // if (posts[index].imageUrl != null)
                //   Image.network(
                //     height: 300,
                //     width: MediaQuery.of(context).size.width,
                //     imageUrl: posts[index].imageUrl!,
                //     fit: BoxFit.cover,
                //   ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: const Icon(
                              Icons.thumb_up_sharp,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(posts[index].likes.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          Text('${posts[index].comments.toString()} comments'),
                          const SizedBox(width: 10),
                          Text('${posts[index].shares.toString()} shares'),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => print('like'),
                          icon: const Icon(Icons.thumb_up_outlined),
                        ),
                        const Text('Like')
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.messenger_outline),
                          onPressed: () => print('comments'),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('comments'),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => print('Share'),
                          icon: const Icon(Icons.share),
                        ),
                        const Text('Share')
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
        childCount: posts.length,
      ),
    );
  }
}
