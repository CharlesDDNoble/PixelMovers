# PixelMovers
An interesting interactive animation that converts an image into another image using the first image's sampled pixels and a little bit of pixel sorting. Written in Processing. Inspired by the work of [Daniel Shiffman](https://shiffman.net/).

### Example

![Example 1](./example_1.gif)


### Overview
Basically, the program maps one image *src* to another image *dst* by:
1. Scaling them to be similar proportions
2. Sampling pixels from each
3. Sorting sampled pixels for both by (luma)[https://en.wikipedia.org/wiki/Luma_(video)].
   The original screen position of each pixel is stored before the sort.
4. Using the sorted index in both as a map between the first image and the second,
   e.g. *sortedImage1*[i] is mapped to *sortedImage2*[i].
5. Each sampled pixel is turned into a particle that moves to its new mapped location
   to create a nifty animation!
