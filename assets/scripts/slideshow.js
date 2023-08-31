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

const iconTitleMapping = {
  cave: "this photo was taken in a cave.",
  chasm: "this photo was taken at a chasm",
  cold: "the subject of this photo boosts cold tolerance.",
  defense: "the subject of this photo can boost defense.",
  depths: "this photo was taken in the depths.",
  fire: "the subject of this photo can provide fire resistance.",
  gloom_repair: "the subject of this photo can restore hearts lost to gloom.",
  glow: "the subject of this photo can make you glow.",
  heart_extra: "the subject of this photo can provide extra hearts.",
  heart: "the subject of this photo can restore hearts.",
  heat: "the subject of this photo can boost heat tolerance.",
  inn: "this photo was taken at an inn.",
  shrine_incomplete: "this photo was taken in a shrine.",
  shrine: "this photo was taken at a shrine",
  sky: "this photo was taken on a sky island.",
  slip: "the subject of this photo can reduce surface slipperiness.",
  speed: "the subject of ths photo can increase movement speed.",
  stable: "this photo was taken at a stable.",
  stamina_extra: "the subject of this photo can provide extra stamina.",
  stamina: "the subject of this photo can restore stamina.",
  stealth: "the subject of this photo can increase stealth.",
  surface: "this photo was taken on the surface.",
  swim_speed: "the subject of this photo can increase swim speed",
  tech_lab: "this photo was taken at a tech lab.",
  tower: "this photo was taken at a skyview tower.",
  village: "this photo was taken in a village.",
  well: "this photo was taken at a well.",
};

function generateIcon(icon) {
  const iconElement = document.createElement("img");
  iconElement.src = `/assets/images/zelda/image_icons/${icon}.svg`;
  iconElement.alt = iconTitleMapping[icon] || "";
  iconElement.title = iconTitleMapping[icon];
  iconElement.className = "image-icon";

  return iconElement;
}

const slideInfo = document.getElementById("slide-info");
const initialTitle = slideInfo.innerHTML;

function updateSlideInfo(currentImage) {
  const title = currentImage.getAttribute("data-title");
  const caption = currentImage.getAttribute("data-caption");
  // zelda only
  const icon = currentImage.getAttribute("data-icon");
  const compendiumEntry = currentImage.getAttribute("data-compendium");

  let updatedSlideInfo = [];

  if (caption) {
    const details = document.createElement("details");
    const summary = document.createElement("summary");

    summary.append(title || initialTitle);
    details.append(summary, caption);

    updatedSlideInfo.push(details);
  } else {
    updatedSlideInfo = [];

    const titleElement = document.createElement("span");
    titleElement.innerHTML = title?.toLowerCase() || initialTitle;

    updatedSlideInfo.push(titleElement);
  }

  // zelda only
  if (icon) {
    const iconElement = generateIcon(icon);
    updatedSlideInfo.push(iconElement);
  }
  if (compendiumEntry) {
    const compendiumElement = document.createElement("span");
    compendiumElement.className = "compendium";

    compendiumElement.innerHTML = compendiumEntry;
    updatedSlideInfo.push(compendiumElement);
  }

  slideInfo.replaceChildren(...updatedSlideInfo);
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

function updateSlideUI() {
  currentImage = getCurrentVisibleImage();

  updateSlideInfo(currentImage);
  updateNavigation(currentImage);
}

window.addEventListener("load", () => {
  updateSlideUI();
});

// webkit doesn't support scrollend T_T
if (currentImage.onscrollend === null) {
  scrollContainer.addEventListener("scrollend", () => {
    updateSlideUI();
  });
} else {
  let timer;
  scrollContainer.addEventListener("scroll", () => {
    clearTimeout(timer);
    timer = setTimeout(updateSlideUI, 150);
  });
}

