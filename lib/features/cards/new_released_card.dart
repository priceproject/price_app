import "package:price_app/features/utils/exports.dart";


class NewReleasedCard extends StatelessWidget {
  const NewReleasedCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final newReleaseBook = allBookData[allBookData.length - 1];
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20.h, // Adjust the height as needed
                      width: 100.w, // Adjust the width as needed
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'New release',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            newReleaseBook['title'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                height: 1.0),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            newReleaseBook['author'],
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ]),
            ),
            Expanded(
              child: ClipRRect(
                child: AspectRatio(
                  aspectRatio: 16/9,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(0.6),
                    child: Image(
                      image: AssetImage(
                       newReleaseBook['imageUrl'],
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

