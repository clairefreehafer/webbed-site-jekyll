---
title: egret
layout: grid
album_key: Mh6pgq
css: >
  .photo-grid {
    grid-template: repeat(2, 1fr) / repeat(6, 1fr);

    @media screen and (orientation: portrait) {
      grid-template: repeat(5, 1fr) / 1fr;
    }
  }
  #image-1 {
    grid-column: 1 / 3;

    @media screen and (orientation: portrait) {
      grid-column: unset;
    }
  }
  #image-2 {
    grid-column: 3 / 5;

    @media screen and (orientation: portrait) {
      grid-column: unset;
    }
  }
  #image-3 {
    grid-column: 5 / 7;

    @media screen and (orientation: portrait) {
      grid-column: unset;
    }
  }
  #image-4 {
    grid-column: 2 / 4;

    @media screen and (orientation: portrait) {
      grid-column: unset;
    }
  }
  #image-5 {
    grid-column: 4 / 6;

    @media screen and (orientation: portrait) {
      grid-column: unset;
    }
  }
---