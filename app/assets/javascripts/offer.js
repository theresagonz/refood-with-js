class Offer {
  constructor(offerJSON) {
    // this.adapter = new OffersAdapter();
    // this.adapter.getOffer(id).then(offerJSON => {     
    //   this.id = offerJSON.id;
    //   this.giverId = offerJSON.giver_id;
    //   this.headline = offerJSON.headline;
    //   this.city = offerJSON.city;
    //   this.state = offerJSON.state;
    //   this.description = offerJSON.description;
    //   this.availability = offerJSON.availability;
    //   this.closed = offerJSON.closed;
    //   this.deleted = offerJSON.deleted;
    //   this.createdAt = offerJSON.created_at;
    // });
    this.displayRequestForm();
    // const id = parseInt($('.js-next').attr('data-id'), 10);
  }

    displayRequestForm() {
    $('#show-request-form').on('click', (e) => {
      e.preventDefault();
      console.log('you clicked make request')
      $('#place-for-request-form').html(this.renderForm());
      $('#show-request-form').html('<h3>New request</h3>')

      this.attachFormSubmitListener();
    });
  }

  attachFormSubmitListener() {
    $('#request-form').on('submit', (e) => {
      e.preventDefault();
      console.log('ayayay')
      $('#place-for-request-form').empty();
    })
  }

  fetchOffer(id) {
    this.adapter.getOffer(id)
      .then(offer => offer.json())
      .then(data => new Offer(data));
  }

  renderLi() {
    return `
      <li class="list-obj left-padding">
        <h5><a href="offers/${this.id}">${this.headline}</a></h5>
        <div>${this.city}, ${this.state}</div>
      </li>
    `;
  }

  renderInfo() {
    $('#offer-description').innerHTML = this.renderLi();
  }

  renderForm() {
    console.log('im in render form')
    return `
    <form id="request-form">
    <div id="request-form-wrapper">
    <div class="form-group">
      <label for="request-message">Message</label>
      <input type="text" id="request-message" class="form-control">
    </div>
    <p><b>Contact me at (at least one is required):</b></p>
    <div class="form-group">
      <label for="requestor-email">Email</label>
      <input type="text" id="requestor-email" class="form-control">
    </div>
    <div class="form-group">
      <label for="requestor-phone">Phone</label>
      <input type="text" id="requestor-phone" class="form-control">
    </div>
    <input type="submit" class="btn btn-primary">
    <a href="/index" class="btn btn-secondary">Cancel</a>
    </div>
    </form>
    `
  }

  submitForm() {
    const id = parseInt($('.js-next').attr('data-id'), 10);
    console.log('submit form id', id)
    $.post(`/offers/${id}/requests`, data, function(returnedData){
      console.log('data', returnedData);
   }).fail(function(){
   console.log("error");
 });
  }
}
