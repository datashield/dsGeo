# dsGeo

##Introduction to example analysis

The purpose of this example is to provide some initial steps for new users of the dsGeo package to walk through the functions provided. It will cover the set up steps required, and then walk through an example analysis, which was used to understand what functions were required in the package.

The objective of the analysis was to understand whether exposure to fast food outlets during commuting had a significant effect on the BMI individuals. The raw data used was a journey expressed as a series of GPS points for each individual and a set of points representing the fast food outlets. The journey points needed to be grouped as line objects, a buffer region defined around the lines and the number of outlets falling inside this buffer counted for each individual to give an exposure. Then, a regression could be performed of exposure against outcome.

Note that the sample datasets are real data repurposed to represent journeys and locations. The BMI data are not realistic.


## Setting up the environment

Follow the usual steps for creating a DataSHIELD test environment:

http://wikis.bris.ac.uk/display/DSDEV/Install+the+test+environment

On your virtual machines, we need to install the following packages as a prerequisite for installing some geospatial R packages:

    sudo apt-get update
    sudo apt-get install libgdal-dev libproj-dev libgeos-dev libcurl4-gnutls-dev

Now install the packages sp, rgdal and rgeos in the same library as the dataSHIELD packages (dsXXXXXXX) - normally something like `/var/lib/rserver/R/x86_64-pc-linux-gnu-library/3.2`

You will also need the tbishop branches of dsGeo and dsBase R packages to be installed on the virtual machines, with the corresponding client R packages. Install these in the usual way, and don't forget the publish the methods on the VMs.

Optionally, you can create a 'danger' function on each virtual server that will allow you to return any object to the client side in order to inspect it. To do this:

1. Go to the DataSHIELD section of the Administration pages in Opal
2. Scroll down to the Methods heading and make sure aggregate is selected
3. Click Add Method
4. Choose R script from the drop down
5. Enter 'danger' for the name
6. Enter the following code ```function(x){return(x)}```

Finally, you need to load the data sets into Opal. The details of this process are beyond the scope of this guide, but you will need the data set that represents each individual's journey, and the data set that represents the fast food outlet locations.

## Running the analysis

### Initial set up

As usual, create a DataSHIELD session:

    logindata <- data.frame(server,url,user,password,table)
    opals <- datashield.login(logins=logindata,assign=TRUE)

As we are using 2 data sets, we also need to assign this to a symbol on the server side:

```datashield.assign(opals, symbol='D2', value='buses.poll_data')```

###Processing the journeys

Convert the standard data frame D into a SpatialPointsDataFrame:

```ds.coordinates('D',c('Lon','Lat'), newobj='buses')```

If you created a 'danger' function, you can take a look at the new object:

```datashield.aggregate(opals,'danger(buses'))```

And here is a visualisation of one person's journey:

![picture1](https://cloud.githubusercontent.com/assets/8521654/10394831/94322a32-6e91-11e5-83f6-42beca7c63b1.png)

Set the projection parameter and then convert the projection from GPS to Irish National Grid (need to confirm whether this is actually necessary or whether you can just work in the GPS projection!):

    ds.proj4string('buses', 4326, 'buses2')
    ds.spTransform('buses2', 29902, 'buses3')

Convert the SpatialPointsDataFrame to SpatialLines. The points are grouped by `bus_id`: this is used to define the lines

```ds.coordsToLines('buses3','bus_id','bus_lines')```

If you created a 'danger' function, you can take a look at the new object:

```datashield.aggregate(opals,'danger(buses3'))```

And here is a visualisation of the line:

![picture2](https://cloud.githubusercontent.com/assets/8521654/10396041/21e4f3f4-6e98-11e5-9256-345b30fc50db.png)

Create a 50m buffer around each journey/line and assign the correct projection

    ds.gBuffer('bus_lines',by_id=T,50,'buffer')
    ds.proj4string('buffer', 29902, 'buffer2')

If you created a 'danger' function, you can take a look at the new object:

```datashield.aggregate(opals,'danger(buffer2'))```

And here is a visualisation of the buffer:

![picture3](https://cloud.githubusercontent.com/assets/8521654/10396056/328980d0-6e98-11e5-8e10-8ffe455a371c.png)

###Adding in the fast food outlets

Convert the standard data frame to points, set the projection and transform for the fast food outlets:

    ds.coordinates('D2',c('Longitude','Latitude'), newobj='ffo')
    ds.proj4string('ffo', 4326, 'ffo2')
    ds.spTransform('ffo2', 29902, 'ffo3')

Overlay the buffered journeys and fast food outlets returning a count of the outlets falling inside the buffer - this is the column `poll_id`

```ds.over('buffer2','ffo3','res')```

If you created a 'danger' function, you can take a look at the new object:

```datashield.aggregate(opals,'danger(res))```

And here is a visualisation:

![picture4](https://cloud.githubusercontent.com/assets/8521654/10396059/3675a926-6e98-11e5-9200-9beda61bd62d.png)

###Prepare for the regression

Note that this section needs the latest tbishop branch for dsBase and dsBaseClient due to the ds.unique function being required 

Return all columns in D, made unique by bus_id:

```ds.unique(x='D',f='bus_id')```

Get rid of columns to keep only bus id and BMI:

```ds.dataframe(x=c('D.unique$bus_id','D.unique$BMI'), newobj='data')```

Create a new data frame containing the bus_id, count of fast food outlets in the buffer and BMI:

```ds.dataframe(c('D.unique$bus_id','res$poll_id','D.unique$BMI'), newobj='for_reg')```

If you created a 'danger' function, you can take a look at the new object:

```datashield.aggregate(opals,'danger(for_reg))```

The data is now ready to do a regression of exposure `res$poll_id` against outcome `D.unique$BMI` which is standard DataSHIELD functionality