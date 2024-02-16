const images = document.getElementsByClassName("photo");

for (let i = 0; i < images.length; i++) {
  const image = images[i];
  const imageDialog = document.getElementById(`info-dialog-${i + 1}`);
  const closeButton = document.getElementById(`info-close-${i + 1}`);

  image.addEventListener("click", () => {
    imageDialog.showModal();
  });

  closeButton.addEventListener("click", () => {
    imageDialog.close();
  });
}
