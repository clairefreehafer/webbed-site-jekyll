const images = document.getElementsByClassName("photo");

for (var i = 0; i < images.length; i++) {
  const image = images[i];
  const imageDialog = document.getElementById(`info-dialog-${i + 1}`);
  const closeButton = document.getElementById(`info-close-${i + 1}`)

  image.addEventListener("click", (e) => {
    imageDialog.showModal();
  });

  closeButton.addEventListener("click", () => {
    imageDialog.close();
  });
}
