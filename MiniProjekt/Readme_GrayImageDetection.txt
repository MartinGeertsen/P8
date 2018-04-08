Replicating an algorithm: Version 1.0,  08/04/2018
An adaptive algorithm for grey image edge detection based on grey correlation analysis
--------------------------------------------------------------------------------------

## Getting Started / Using it

You can use any pictures in the code even if they are not gray scaled. You'll have to replace the x's in: "RGB = imread('xxxxxx.jpg');" with your own image to see how the works of the algorithm. Be aware that large pictures may take some time to compute. A picture of 300x300 takes 25 minutes on a slow computer. 

Use the command: imshow(uint8(x)), where x is any of the variables in the code to see each step of the code. Some of the variables need to be multiplied with 255 to generate an image.
Some of the variables that'll generate an images are: r*255, T, I, K1b.
------------------------------------------------------------------------

### Prerequisites

You need Matlab and a picture from your computer. 
-----------------------------------------------

## Contributing
The aurthers of the algorithm
@Conference{Baoming2016,
  author = {Qiao Baoming and Jin Liu and Yang Yufan},
  title  = {An Adaptive Algorithm for Grey Image Edge Detection Based on Grey Correlation Analysis},
  year   = {2016},
  venue  = {12th International Conference on Computational Intelligence and Security},
}
-------------------------------------------------------------------------------------------------------
## Authors

PDP8 students:
- Karolis M. Nielsen
- Alexander Flyvholm Povlsen
- Martin Geertsen
- Kasper Ravnkilde

Group: 18gr881
E-mail: 18gr881@es.aau.dk
------------------------------

## Acknowledgments

Thanks to Kamal Nasrollahi and Mohammad Ahsanul Haque from AAU for assistance.