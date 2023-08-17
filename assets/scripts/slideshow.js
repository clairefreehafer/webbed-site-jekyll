function isElementInViewport(el) {
  var rect = el.getBoundingClientRect();

  return (
    rect.top >= 0 &&
    rect.left >= 0 &&
    rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
    rect.right <= (window.innerWidth || document.documentElement.clientWidth)
  );
}

const images = document.getElementsByClassName("photo");

function getCurrentVisibleImage() {
  for (const index in images) {
    const image = images[index];

    if (isElementInViewport(image)) {
      return image;
    }
  }
}

const pageTitle = document.getElementById("page-title");
const initialTitle = pageTitle.innerHTML;

function updatePageTitle(currentImage) {
  const title = currentImage.getAttribute("data-title");

  if (title) {
    pageTitle.innerHTML = title.toLowerCase();
  } else {
    pageTitle.innerHTML = initialTitle;
  }
}

const currentSlide = document.getElementById("current-slide");
const previousSlide = document.getElementById("previous-slide");
const nextSlide = document.getElementById("next-slide");
const totalSlides = Number(document.getElementById("total-slides").innerHTML);

function updateNavigation(currentImage) {
  const currentSlideNumber = Number(currentImage.getAttribute("id").slice(6));
  currentSlide.innerHTML = currentSlideNumber;

  if (currentSlideNumber > 1) {
    previousSlide.style.display = "inline";
    previousSlide.href = `#slide-${currentSlideNumber - 1}`;
  } else {
    previousSlide.style.display = "none";
  }

  if (currentSlideNumber === totalSlides) {
    nextSlide.style.display = "none";
  } else {
    nextSlide.style.display = "inline";
    nextSlide.href = `#slide-${currentSlideNumber + 1}`;
  }

}

const scrollContainer = document.getElementById("scroll-container");
let currentImage = getCurrentVisibleImage();

window.addEventListener("load", () => {
  updatePageTitle(currentImage);
  updateNavigation(currentImage);
});

scrollContainer.addEventListener("scrollend", () => {
  currentImage = getCurrentVisibleImage();

  updatePageTitle(currentImage);
  updateNavigation(currentImage);
});
