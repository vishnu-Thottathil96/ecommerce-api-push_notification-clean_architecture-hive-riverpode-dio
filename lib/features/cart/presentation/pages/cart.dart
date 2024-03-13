import 'package:aqua_assignment/core/constants/app_colors.dart';
import 'package:aqua_assignment/core/util/add_gst.dart';
import 'package:aqua_assignment/features/cart/presentation/riverpod/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartStateNotifierProvider);
    // Calculate the total price
    final price = cartItems.fold<double>(
        0,
        (previousValue, item) =>
            previousValue + (item.price ?? 0) * (item.count));

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
        title: Text('Cart ( ${cartItems.length} )'),
      ),
      bottomNavigationBar: Container(
        color: Colors.white70,
        height: height / 5.5,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      '$price',
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'GST(18%)',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      '${GstCalculation.calculateNthPercentageOfPrice(price, 18)}',
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      ' ${GstCalculation.addGstToPrice(price)}',
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Empty Cart'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
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
                            color: AppColors.amberColor,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                item.thumbnail ?? '',
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
                                  item.title ?? 'No title',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 14 *
                                          MediaQuery.textScaleFactorOf(context),
                                      fontWeight: FontWeight.w900),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item.description ?? 'No description',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(fontSize: 14 * textScale),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "₹ ${item.price}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 14 * textScale),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(cartStateNotifierProvider
                                                .notifier)
                                            .updateItem(item, false);
                                      },
                                      child: const Text('-'),
                                    ),
                                    Flexible(
                                      // Wrap the Text widget with Flexible
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text(
                                          '${item.count}',
                                          textAlign: TextAlign
                                              .center, // Center the text (optional)
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(cartStateNotifierProvider
                                                .notifier)
                                            .updateItem(item, true);
                                      },
                                      child: const Text('+'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RatingBar.builder(
                                allowHalfRating: true,
                                itemSize: 20,
                                ignoreGestures: true,
                                initialRating: item.rating ?? 0,
                                itemCount: 5,
                                itemBuilder: (context, _) =>
                                    const Icon(Icons.star, color: Colors.amber),
                                onRatingUpdate: (rating) {},
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  ref
                                      .read(cartStateNotifierProvider.notifier)
                                      .removeItem(item);
                                },
                                icon: const Icon(Icons.delete_outline))
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
