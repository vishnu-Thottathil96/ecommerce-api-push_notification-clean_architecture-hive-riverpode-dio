import 'package:aqua_assignment/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isList = true;

  @override
  Widget build(BuildContext context) {
    // MediaQuery data for responsive design
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Calculate sizes based on screen size
    double containerHeight = height * 0.25;
    double imageWidth = width * 0.25;

    // Dynamic text scaling
    double textScale = MediaQuery.textScaleFactorOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: const Text('E Commerce App'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isList = !isList;
              });
            },
            icon: const Icon(Icons.menu),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Badge(
              label: const Text('0'),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ));
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: isList
            ? ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: containerHeight,
                      color: Colors.grey[400],
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: imageWidth,
                              color: Colors.amber,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  'https://via.placeholder.com/150',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Dynamic text sizing example
                                  Text(
                                    'Title',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontSize: 16 * textScale),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Description',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 14 * textScale),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Price',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontSize: 14 * textScale),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RatingBar.builder(
                                  itemSize: 20,
                                  ignoreGestures: true,
                                  initialRating: 3,
                                  itemCount: 5,
                                  itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber),
                                  onRatingUpdate: (rating) {},
                                ),
                              ),
                              const Text('3.5')
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : // GridView remains the same
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey[400],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
