// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

$(document).ready(function() {
  setTimeout(function() {
    $('.alert').slideUp();
  }, 2000);

  if ($('.sidebar')) {
    let sectionHeight = $('.the-content').height() + 100;
    $('.sidebar').height(sectionHeight);
  }

  $('.panel-heading .kebab').on('click', function() {
    $(this).siblings('.panel-heading-menu').toggleClass('hidden');
  });

  $('[data-toggle="tooltip"]').tooltip();
  $('.header-button .btn-secondary').tooltip();
  $('.header-button .btn-danger').tooltip();

  if ($('.badge')) {
    $('.badge').each(function() {
      let rgb = $(this).css('backgroundColor');
      let colors = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);

      let r = colors[1];
      let g = colors[2];
      let b = colors[3];

      let textColor;

      if (Number(colors[1]) + Number(colors[2]) + Number(colors[3]) > 470) {
        textColor = '#000000';
      } else {
        textColor = '#ffffff';
      }

      $(this).css('color', textColor);
    });
  }

  $('.panel-truncate p').each(function() {
    if ( $(this).html().length > 110 ) {
      let truncText = $(this).html().substring(0,110) + '...';
      $(this).html(truncText);
    }
  });

  $('.markdown-text').each(function() {
    if ( $(this).html().length > 300 ) {
      let truncText = $(this).html().substring(0,300) + '...';
      $(this).html(truncText);
    }
  });

  if ( $('#markdown') ) {
    var simplemde = new SimpleMDE({ element: document.getElementById("markdown") });
  }

  $('.markdown-text').each(function() {
    var text = $(this).html();
    var converter = new showdown.Converter({headerLevelStart: 3});
    var html = converter.makeHtml(text);
    $(this).html(html);
  });
})

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
