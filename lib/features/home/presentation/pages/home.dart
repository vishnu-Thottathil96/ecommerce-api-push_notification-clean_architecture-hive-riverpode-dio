import 'package:aqua_assignment/core/constants/app_colors.dart';
import 'package:aqua_assignment/features/cart/data/models/cart_item.dart';
import 'package:aqua_assignment/features/cart/presentation/pages/cart.dart';
import 'package:aqua_assignment/features/cart/presentation/riverpod/cart_state.dart';
import 'package:aqua_assignment/features/home/domain/entity/product_entity.dart';
import 'package:aqua_assignment/features/home/presentation/riverpod/home_provider.dart';
import 'package:aqua_assignment/core/util/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Assuming 'ProductEntity' and 'productsProvider' are defined as shown above

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isList = true;

  @override
  Widget build(BuildContext context) {
    final productsAsyncValue = ref.watch(productsProvider);
    final cartItems = ref.read(cartStateNotifierProvider.notifier);
    final cartLength = ref.watch(cartStateNotifierProvider);

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
        backgroundColor: AppColors.greyColor,
        title: const Text('E-Commerce App'),
        actions: [
          IconButton(
            icon: Icon(isList ? Icons.grid_view : Icons.list),
            onPressed: () {
              setState(() {
                isList = !isList;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Badge(
              label: Text('${cartLength.length}'),
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
      body: productsAsyncValue.when(
        data: (products) => isList
            ? _buildListView(
                products, containerHeight, imageWidth, textScale, cartItems)
            : _buildGridView(products),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildListView(
    List<ProductEntity> products,
    double containerHeight,
    double imageWidth,
    double textScale,
    CartStateNotifier cartItems,
  ) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: containerHeight,
            color: AppColors.greyColor,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: imageWidth,
                    color: AppColors.greyColor,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize:
                                  14 * MediaQuery.textScaleFactorOf(context),
                              fontWeight: FontWeight.w900),
                        ),
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
                          "\$ ${product.price.toString()}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 14 * textScale),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            cartItems.addItem(
                              CartElement(
                                  id: product.id,
                                  title: product.title,
                                  description: product.description,
                                  price: product.price.toInt(),
                                  discountPercentage:
                                      product.discountPersentage.toDouble(),
                                  rating: product.rating.toDouble(),
                                  stock: product.stock.toInt(),
                                  brand: product.brand,
                                  category: product.category,
                                  thumbnail: product.thumbnail,
                                  images: product.images,
                                  count: 1),
                            );
                            ShowNotification.showToast(
                                '${product.title} added to cart');
                          },
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(fontSize: 14, color: Colors.blue),
                          ),
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
                        itemBuilder: (context, _) =>
                            Icon(Icons.star, color: AppColors.amberColor),
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
  }

  Widget _buildGridView(List<ProductEntity> products) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: Image.network(product.thumbnail, fit: BoxFit.cover)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(product.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('\$${product.price}'),
              ),
            ],
          ),
        );
      },
    );
  }
}
