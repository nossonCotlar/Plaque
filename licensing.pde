
public void displayLicenseWatermark() {
  if (license) return;
  textAlign(CENTER);
  pushStyle();
  textSize(100);
  fill(0);
  text("Product is unlicensed", width / 2, height / 2);

  popStyle();
}
