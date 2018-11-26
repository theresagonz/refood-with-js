class Offers {
  static fetchAndLoadOffers() {
    const offersArray = [];
    OffersAdapter.getOffers()
      .then(offers => {
        offers.forEach(offer => {
          offersArray.push(new Offer(offer));
        });
      })
      .then(() => Offers.render(offersArray))
      .catch(error => console.error(error));
  }

  static alphaFetchAndLoadOffers() {
    const offersArray = [];
    OffersAdapter.getOffers()
    .then(offers => {
      offers.sort(Offers.compareOffers);
      offers.forEach(offer => {
        offersArray.push(new Offer(offer));
      });
    })
    .then(() => {
      Offers.render(offersArray)
    })
    .catch(error => console.error(error));
  }

  static compareOffers(a, b) {
    var headlineA = a.headline.toUpperCase(); // ignore upper and lowercase
    var headlineB = b.headline.toUpperCase(); // ignore upper and lowercase
    if (headlineA < headlineB) {
      return -1;
    }
    if (headlineA > headlineB) {
      return 1;
    }
    return 0;
  }

  static render(offersArray) {
    document.querySelector('#offers-list').innerHTML = offersArray.map(offer => offer.renderLi()).join('');
  }
}
