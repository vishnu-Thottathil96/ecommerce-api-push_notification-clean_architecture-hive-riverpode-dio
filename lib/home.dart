import 'package:aqua_assignment/cart.dart';
import 'package:aqua_assignment/main.dart';
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
            ? FutureBuilder(
                future: a(),
                builder: (context, value) {
                  return ListView.builder(
                    itemCount: value.data!.length,
                    itemBuilder: (context, index) {
                      final product = value.data![index];
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
                                      product.thumbnail,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        product.title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 14 *
                                                MediaQuery.textScaleFactorOf(
                                                    context),
                                            fontWeight: FontWeight.w900),
                                      ),
                                      // Dynamic text sizing example
                                      // Text(
                                      //   product.title,
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .titleLarge!
                                      //       .copyWith(fontSize: 16 * textScale),
                                      // ),
                                      const SizedBox(height: 8),
                                      Text(
                                        product.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(fontSize: 14 * textScale),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "₹ ${product.price.toString()}",
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
                                      allowHalfRating: true,
                                      itemSize: 20,
                                      ignoreGestures: true,
                                      initialRating: product.rating.toDouble(),
                                      itemCount: 5,
                                      itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber),
                                      onRatingUpdate: (rating) {},
                                    ),
                                  ),
                                  Text(product.rating.toString())
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                })
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: a(),
                    builder: (context, value) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                        ),
                        itemCount: value.data!.length,
                        itemBuilder: (context, index) {
                          final product = value.data![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: double.infinity,
                                  color: Colors.amber,
                                  child: AspectRatio(
                                    aspectRatio: 1.5,
                                    child: Image.network(
                                      product.thumbnail,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  product.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 14 *
                                          MediaQuery.textScaleFactorOf(
                                              context)),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
              ),
      ),
    );
  }
}
