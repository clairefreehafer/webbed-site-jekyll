const gridInfo = document.getElementById("grid-info");
const dialog = document.getElementById("info-dialog");
const dialogTable = document.getElementById("photo-table");
const closeButton = document.getElementById("info-close");

const images = document.getElementsByClassName("photo");

function updateTableRow(id, key, value) {
  const row = document.getElementById(id);

  const keyEl = document.createElement("div");
  keyEl.append(key);

  const valueEl = document.createElement("div");
  valueEl.append(value);

  row.replaceChildren(keyEl, valueEl);
}

function updateDialogInfo(image) {
  const title = image.getAttribute("data-title");
  if (title) {
    const titleEl = document.getElementById("image-title");
    titleEl.innerHTML = title;
  }

  const date = image.getAttribute("data-date");
  if (date) {
    const dateObj = new Date(date);
    updateTableRow("photo-date", "date", dateObj.toLocaleDateString(undefined, {
      month: "long",
      day: "numeric",
      year: "numeric",
    }));
  }
}

for (var i = 0; i < images.length; i++) {
  const image = images[i];

  image.addEventListener("click", (e) => {
    console.log(e.target);
    dialog.showModal();
    updateDialogInfo(image);
  });
}

closeButton.addEventListener("click", () => {
  dialog.close();
});
