# dsGeo

##Introduction to example analysis

The purpose of this example is to provide some initial steps for new users of the dsGeo package to walk through the functions provided. It will cover the set up steps required, and then walk through an example analysis, which was used to understand what functions were required in the package.

The objective of the analysis was to understand whether exposure to fast food outlets during commuting had a significant effect on the BMI individuals. The raw data used was a journey expressed as a series of GPS points for each individual and a set of points representing the fast food outlets. The journey points needed to be grouped as line objects, a buffer region defined around the lines and the number of outlets falling inside this buffer counted for each individual to give an exposure. Then, a regression could be performed of exposure against outcome.


## Setting up the environment

Follow the usual steps for creating a DataSHIELD test environment:

http://wikis.bris.ac.uk/display/DSDEV/Install+the+test+environment

On your virtual machines, we need to install the following packages as a prerequisite for installing some geospatial R packages:

    sudo apt-get update
    sudo apt-get install libgdal-dev libproj-dev libgeos-dev libcurl4-gnutls-dev

Now install the packages sp, rgdal and rgeos in the same library as the dataSHIELD packages (dsXXXXXXX) - normally something like `/var/lib/rserver/R/x86_64-pc-linux-gnu-library/3.2`

Optionally, you can create a 'danger' function on each virtual server that will allow you to return any object to the client side in order to inspect it. To do this:

1. Go to the DataSHIELD section of the Administration pages in Opal
2. Scroll down to the Methods heading and make sure aggregate is selected
3. Click Add Method
4. Choose R script from the drop down
5. Enter 'danger' for the name
6. Enter the following code:

````function(x){return(x)}````

Finally, you need to load the datasets into Opal

https://cloud.githubusercontent.com/assets/8521654/10394831/94322a32-6e91-11e5-83f6-42beca7c63b1.png

