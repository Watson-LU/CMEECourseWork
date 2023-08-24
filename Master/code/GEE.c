/* Function to mask clouds using the Sentinel-2 QA band
 * @param {ee.Image} image Sentinel-2 image
 * @return {ee.Image} cloud masked Sentinel-2 image
 */
function maskS2clouds(image) {
  var qa = image.select('QA60');
  // Bits 10 and 11 are clouds and cirrus, respectively.
  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;
  // Both flags should be set to zero, indicating clear conditions.
  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
      .and(qa.bitwiseAnd(cirrusBitMask).eq(0));
  return image.updateMask(mask).divide(10000);
}
var dataset = ee.ImageCollection('COPERNICUS/S2_SR')
                  .filterBounds(fit)
                  .filterDate('2021-01-01', '2022-12-30')
                  // Pre-filter to get less cloudy granules.
                  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE',10))
                  .map(maskS2clouds)
                  .median()
                  
//Map.addLayer(dataset)  //step1
var final_image = dataset.clip(ww); Map.addLayer(final_image,ss, "final_1");Export.image.toDrive({  image:final_image ,  description: 'try',  region: ww,  scale: 10,  fileFormat: 'GeoTIFF',});

//Map.addLayer(dataset, ss,"final_1") //useless