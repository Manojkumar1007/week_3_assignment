import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/api/constants.dart';
import 'package:movies_app/models/wishlist.dart';
import 'package:movies_app/pages/details_page2.dart';
import 'package:movies_app/pages/home_page.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {

  void removeFromWishlist(Movie movie){
    Provider.of<Wishlist>(context,listen: false).removeMovieFromWishlist(movie);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Wishlist>(
        builder: (context,value,child) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => const HomePage()
              )),
            ),
            title: Text('Wishlist', style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),),
          ),
          body: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 733,
                // width: double.infinity,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                    itemCount: value.wishlist.length,
                    itemBuilder: (context,index){
                    Movie eachMovie = value.wishlist[index] ;
                    return GestureDetector(
                      onTap: ()=> Navigator.push(context,MaterialPageRoute(
                          builder: (context) => DetailsPage2(movie: eachMovie),
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: SizedBox(
                            height: 600,
                            width: 600,
                            child: Stack(
                                children: [
                                  Image.network(
                                      '${Constants.imagePath}${eachMovie.posterPath}',
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  ),
                                  GestureDetector(
                                    onTap: () => removeFromWishlist(eachMovie),
                                    child: Positioned.fill(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(30),
                                            child: Container(
                                              height: 60,
                                              width: 60,
                                              color: Colors.black54,
                                              child: const Icon(Icons.remove,size: 36),
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
              ),
            ],
          ),
        ),
    );
  }
}
