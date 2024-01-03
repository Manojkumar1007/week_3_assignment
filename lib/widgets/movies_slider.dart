import 'package:flutter/material.dart';
import 'package:movies_app/api/constants.dart';
import 'package:movies_app/pages/details_page.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../models/wishlist.dart';

class MovieSlider extends StatefulWidget {

  MovieSlider({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot snapshot ;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  void addToWishlist(Movie movie){
    Provider.of<Wishlist>(context,listen: false).addMovieToWishlist(movie);
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.snapshot.data.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DetailsPage(movie: widget.snapshot.data[index])
              )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 200,
                    width: 150,
                    child: Stack(
                        children : [
                          Image.network(
                            '${Constants.imagePath}${widget.snapshot.data[index].posterPath}',
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                          ),
                          GestureDetector(
                            onTap: () => addToWishlist(widget.snapshot.data[index]),
                            child: Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.black54,
                                      child: const Icon(Icons.add,size: 30),
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
              ),
            );
          }
      ),
    );
  }
}
