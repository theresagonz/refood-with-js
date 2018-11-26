$(document).on('turbolinks:load', () => {
  // init();

  switch (window.location.pathname) {
    case '/offers':
      Offer.fetchAndLoadOffers();
      break;
    default:
      console.log('not on offers index')
  }
});

// init() {
//   Offer.
// }
