import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/pages/details_page.dart';
import 'package:provider/provider.dart';
import '../api/constants.dart';
import '../models/movie.dart';
import '../models/wishlist.dart';

class TrendingSlider extends StatefulWidget {
  TrendingSlider({super.key, required this.snapshot});

  final AsyncSnapshot snapshot ;

  @override
  State<TrendingSlider> createState() => _TrendingSliderState();
}

class _TrendingSliderState extends State<TrendingSlider> {
  void addToWishlist(Movie movie){
    Provider.of<Wishlist>(context,listen: false).addMovieToWishlist(movie);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: widget.snapshot.data.length,
        options: CarouselOptions(
          height: 300,
          autoPlay: true,
          viewportFraction: 0.55,
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          autoPlayAnimationDuration: const Duration(seconds: 2),
        ),
        itemBuilder: (context,itemIndex,pageViewIndex) {
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return DetailsPage(movie: widget.snapshot.data[itemIndex]);
                }
            )),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 300,
                width: 200,
                child: Stack(
                  children: [
                    Image.network(
                      '${Constants.imagePath}${widget.snapshot.data[itemIndex].posterPath}',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                    GestureDetector(
                      onTap: ()=> addToWishlist(widget.snapshot.data[itemIndex]),
                      child: Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  color: Colors.black54,
                                  child: const Icon(Icons.add,size: 36),
                                ),
                              ),
                            ),
                          ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
