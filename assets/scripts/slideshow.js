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

const slideInfo = document.getElementById("slide-info");
const initialTitle = slideInfo.innerHTML;

function updatePageTitle(currentImage) {
  const title = currentImage.getAttribute("data-title");
  const caption = currentImage.getAttribute("data-caption");

  let updatedSlideInfo;

  if (caption) {
    updatedSlideInfo = document.createElement("details");
    const summary = document.createElement("summary");
    summary.innerHTML = title || initialTitle;

    updatedSlideInfo.append(summary, caption);
  } else {
    updatedSlideInfo = document.createElement("div");

    updatedSlideInfo.innerHTML = title?.toLowerCase() || initialTitle;
  }

  slideInfo.replaceChildren(updatedSlideInfo);
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
