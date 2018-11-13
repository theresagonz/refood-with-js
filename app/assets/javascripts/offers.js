class Offers {
  constructor() {
    this.offers = [];
    this.adapter = new OffersAdapter();
    this.initBindingsAndEventListeners();
    this.fetchAndLoadOffers();
  }

  initBindingsAndEventListeners() {
    this.offersList = document.querySelector('#offers-list');
  }

  fetchAndLoadOffers() {
    this.adapter.getOffers()
      .then(offers => {
        console.log('offers', offers);
        
        offers.forEach(offer => {
          this.offers.push(new Offer(offer));
        });
      })
      .then(() => this.render())
      .catch(error => console.error(error));
  }

  render() {
    this.offersList.innerHTML = this.offers.map(offer => offer.renderLi()).join('');
  }
}
